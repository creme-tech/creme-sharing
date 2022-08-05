import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:creme_sharing/assets/colors/app_colors.dart';
import 'package:creme_sharing/assets/fonts/app_fonts.dart';
import 'package:creme_sharing/assets/svg/app_svg.dart';
import 'package:creme_sharing/utils/user_avatar_widget.dart';

class CookedStickerWidget extends StatelessWidget {
  final Uint8List? imageBackgroundImageBytes;
  final Uint8List creatorAvatarImageBytes;
  final Uint8List? userAvatarImageBytes;
  final Uint8List cookedImageBytes;
  final String userName;
  final String creatorName;
  final String recipeName;
  final String cremeLogoMessage;
  final Color? backgroundColor;
  final Size userAvatarSize;
  final Size creatorAvatarSize;
  final Size cookedImageSize;
  final Size imageBackgroundSize;
  final double devicePixelRatio;
  final bool hasVideoOnBackground;
  final double? textScaleFactor;

  const CookedStickerWidget({
    Key? key,
    required this.textScaleFactor,
    required this.creatorAvatarImageBytes,
    required this.userAvatarImageBytes,
    required this.cookedImageBytes,
    required this.imageBackgroundImageBytes,
    required this.userName,
    required this.creatorName,
    required this.recipeName,
    required this.cremeLogoMessage,
    required this.backgroundColor,
    required this.userAvatarSize,
    required this.creatorAvatarSize,
    required this.cookedImageSize,
    required this.imageBackgroundSize,
    required this.devicePixelRatio,
    required this.hasVideoOnBackground,
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
          if (!hasVideoOnBackground && imageBackgroundImageBytes != null)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.memory(
                  imageBackgroundImageBytes!,
                  fit: BoxFit.cover,
                  height: imageBackgroundSize.height,
                  width: imageBackgroundSize.width,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          if (!hasVideoOnBackground && imageBackgroundImageBytes != null)
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: cookedImageSize.height,
                        width: cookedImageSize.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.memory(
                            cookedImageBytes,
                            height: cookedImageSize.height,
                            width: cookedImageSize.width,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 70,
                        height: 40,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              width: 40,
                              top: 0,
                              bottom: 0,
                              child: SizedBox(
                                height: creatorAvatarSize.height,
                                width: creatorAvatarSize.width,
                                child: ClipOval(
                                  child: Image.memory(
                                    creatorAvatarImageBytes,
                                    height: creatorAvatarSize.height,
                                    width: creatorAvatarSize.width,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              width: 40,
                              top: 0,
                              bottom: 0,
                              child: UserAvatarWidget(
                                avatarImageBytes: userAvatarImageBytes,
                                name: userName,
                                avatarSize: userAvatarSize,
                                letterTextStyle: null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recipeName,
                        style: AppFonts.bodyBold.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                        textScaleFactor: textScaleFactor ??
                            MediaQuery.of(context).textScaleFactor,
                      ),
                      Text(
                        '$creatorName &\n$userName',
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
                      const SizedBox(height: 134),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
