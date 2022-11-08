import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:creme_sharing/assets/colors/app_colors.dart';
import 'package:creme_sharing/assets/fonts/app_fonts.dart';
import 'package:creme_sharing/assets/svg/app_svg.dart';

class CreatorStickerWidget extends StatelessWidget {
  final Uint8List? imageBackgroundImageBytes;
  final Uint8List creatorAvatarImageBytes;
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
    required this.creatorAvatarImageBytes,
    required this.imageBackgroundImageBytes,
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
    if (!hasVideoOnBackground) {
      const width = 375.0;
      const height = 700.0;
      return Container(
        color: backgroundColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              children: [
                if (imageBackgroundImageBytes != null)
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.memory(
                        imageBackgroundImageBytes!,
                        fit: BoxFit.cover,
                        height: width,
                        width: height,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                if (imageBackgroundImageBytes != null)
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    SizedBox(
                      height: creatorAvatarSize.height,
                      width: creatorAvatarSize.width,
                      child: ClipOval(
                        child: Image.memory(
                          creatorAvatarImageBytes,
                          height: creatorAvatarSize.height,
                          width: creatorAvatarSize.width,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          alignment: Alignment.topCenter,
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
                      style: AppFonts.bodyRegular
                          .copyWith(color: AppColors.white50),
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
                    const SizedBox(height: 54),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    final screenSize = MediaQuery.of(context).size;
    final width =
        Platform.isIOS ? screenSize.width * 261 / 375 : screenSize.width * 0.85;
    return Container(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: Platform.isIOS ? width / 0.431 : null,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (Platform.isIOS) const Spacer(),
              SizedBox(
                height: creatorAvatarSize.height,
                width: creatorAvatarSize.width,
                child: ClipOval(
                  child: Image.memory(
                    creatorAvatarImageBytes,
                    height: creatorAvatarSize.height,
                    width: creatorAvatarSize.width,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                creatorName,
                style: AppFonts.bodyBold.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
                textScaleFactor:
                    textScaleFactor ?? MediaQuery.of(context).textScaleFactor,
              ),
              Text(
                creatorTag,
                style: AppFonts.bodyRegular.copyWith(color: AppColors.white50),
                textAlign: TextAlign.center,
                textScaleFactor:
                    textScaleFactor ?? MediaQuery.of(context).textScaleFactor,
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
                    style:
                        AppFonts.bodyRegular.copyWith(color: AppColors.white50),
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
              if (Platform.isIOS) const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
