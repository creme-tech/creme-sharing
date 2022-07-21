import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:creme_sharing/assets/colors/app_colors.dart';
import 'package:creme_sharing/assets/fonts/app_fonts.dart';
import 'package:creme_sharing/assets/svg/app_svg.dart';

class RecipeStickerWidget extends StatelessWidget {
  final Uint8List creatorAvatarImage;
  final Uint8List recipeImage;
  final String creatorName;
  final String recipeName;
  final String cremeLogoMessage;
  final Color backgroundColor;

  const RecipeStickerWidget({
    Key? key,
    required this.creatorAvatarImage,
    required this.recipeImage,
    required this.creatorName,
    required this.recipeName,
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
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical -
                    48,
                width: MediaQuery.of(context).size.width,
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
                        height: 261,
                        width: 261,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.memory(
                            recipeImage,
                            height: 261,
                            width: 261,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
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
                        recipeName,
                        style: AppFonts.bodyBold.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      ),
                      Text(
                        creatorName,
                        style: AppFonts.bodyRegular
                            .copyWith(color: AppColors.white50),
                        textAlign: TextAlign.center,
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
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
