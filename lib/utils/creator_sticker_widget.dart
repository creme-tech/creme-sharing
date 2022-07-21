import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:creme_sharing/assets/colors/app_colors.dart';
import 'package:creme_sharing/assets/fonts/app_fonts.dart';
import 'package:creme_sharing/assets/svg/app_svg.dart';

class CreatorStickerWidget extends StatelessWidget {
  final Uint8List creatorAvatarImage;
  final String creatorName;
  final String creatorTag;
  final String cremeLogoMessage;
  final Color backgroundColor;

  const CreatorStickerWidget({
    Key? key,
    required this.creatorAvatarImage,
    required this.creatorName,
    required this.creatorTag,
    required this.cremeLogoMessage,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.memory(
                creatorAvatarImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                children: [
                  const Spacer(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: ClipOval(
                            child: Image.memory(
                              creatorAvatarImage,
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          creatorName,
                          style:
                              AppFonts.bodyBold.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                        ),
                        Text(
                          creatorTag,
                          style: AppFonts.bodyRegular
                              .copyWith(color: AppColors.white50),
                          textAlign: TextAlign.center,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor,
                        ),
                        const SizedBox(height: 34),
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
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor,
                            ),
                            const SizedBox(width: 4),
                            SvgPicture.asset(
                              AppSvg.cremeLogo,
                              package: 'creme_sharing',
                              height: 29,
                              width: 35,
                              fit: BoxFit.fill,
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Spacer(),
                      ],
                    ),
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
