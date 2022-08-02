import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:creme_sharing/assets/colors/app_colors.dart';
import 'package:creme_sharing/assets/fonts/app_fonts.dart';
import 'package:creme_sharing/assets/svg/app_svg.dart';

class CreatorStickerWidget extends StatelessWidget {
  final File? imageBackgroundFile;
  final File creatorAvatarFile;
  final Size extraRecipesImageSize;
  final String creatorName;
  final String cremeLogoMessage;
  final Color? backgroundColor;
  final Size creatorAvatarSize;
  final Size imageBackgroundSize;
  final double devicePixelRatio;
  final bool hasVideoOnBackground;
  final double? textScaleFactor;
  final String creatorTag;

  const CreatorStickerWidget({
    Key? key,
    required this.extraRecipesImageSize,
    required this.textScaleFactor,
    required this.creatorAvatarFile,
    required this.imageBackgroundFile,
    required this.creatorName,
    required this.cremeLogoMessage,
    required this.backgroundColor,
    required this.creatorAvatarSize,
    required this.imageBackgroundSize,
    required this.devicePixelRatio,
    required this.hasVideoOnBackground,
    required this.creatorTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const packageName = 'creme_sharing';
    return Container(
      color: hasVideoOnBackground
          ? Colors.transparent
          : backgroundColor ?? Colors.transparent,
      child: Stack(
        children: [
          if (!hasVideoOnBackground && imageBackgroundFile != null)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.file(
                  imageBackgroundFile!,
                  fit: BoxFit.cover,
                  height: imageBackgroundSize.height,
                  width: imageBackgroundSize.width,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          if (!hasVideoOnBackground && imageBackgroundFile != null)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black87,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Spacer(),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: creatorAvatarSize.height,
                    width: creatorAvatarSize.width,
                    child: ClipOval(
                      child: Image.file(
                        creatorAvatarFile,
                        height: creatorAvatarSize.height,
                        width: creatorAvatarSize.width,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    creatorName,
                    style: AppFonts.bodyBold.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                    textScaleFactor: textScaleFactor ??
                        MediaQuery.of(context).textScaleFactor,
                  ),
                  Text(
                    creatorTag,
                    style:
                        AppFonts.bodyRegular.copyWith(color: AppColors.white50),
                    textAlign: TextAlign.center,
                    textScaleFactor: textScaleFactor ??
                        MediaQuery.of(context).textScaleFactor,
                  ),
                  const SizedBox(height: 78),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        cremeLogoMessage,
                        style: AppFonts.bodyRegular
                            .copyWith(color: AppColors.white50),
                        textAlign: TextAlign.center,
                        textScaleFactor: textScaleFactor ??
                            MediaQuery.of(context).textScaleFactor,
                      ),
                      const SizedBox(width: 4),
                      SvgPicture.asset(
                        AppSvg.cremeLogo,
                        package: packageName,
                        height: 29,
                        width: 35,
                        fit: BoxFit.fill,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 134),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
