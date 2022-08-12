import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:creme_sharing/assets/colors/app_colors.dart';
import 'package:creme_sharing/assets/fonts/app_fonts.dart';
import 'package:creme_sharing/assets/svg/app_svg.dart';

class RecipeStickerWidget extends StatelessWidget {
  final Uint8List? imageBackgroundImageBytes;
  final Uint8List creatorAvatarImageBytes;
  final Uint8List recipeImageImageBytes;
  final Size extraRecipesImageSize;
  final String creatorName;
  final String recipeName;
  final String creatorTag;
  final String cremeLogoMessage;
  final Color? backgroundColor;
  final Size creatorAvatarSize;
  final Size recipeImageSize;
  final Size imageBackgroundSize;
  final double devicePixelRatio;
  final bool hasVideoOnBackground;
  final double? textScaleFactor;
  final List<RecipeData> extraRecipesToShow;
  final String packageName = 'creme_sharing';

  const RecipeStickerWidget({
    Key? key,
    required this.recipeImageImageBytes,
    required this.extraRecipesImageSize,
    required this.textScaleFactor,
    required this.creatorAvatarImageBytes,
    required this.imageBackgroundImageBytes,
    required this.creatorName,
    required this.creatorTag,
    required this.recipeName,
    required this.cremeLogoMessage,
    required this.backgroundColor,
    required this.creatorAvatarSize,
    required this.recipeImageSize,
    required this.imageBackgroundSize,
    required this.devicePixelRatio,
    required this.hasVideoOnBackground,
    required this.extraRecipesToShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const packageName = 'creme_sharing';
    if (hasVideoOnBackground) {
      return _RecipeStickerToBackgroundVideoWidget(
        creatorTag: creatorTag,
        imageBackgroundImageBytes: imageBackgroundImageBytes,
        creatorAvatarImageBytes: creatorAvatarImageBytes,
        recipeImageImageBytes: recipeImageImageBytes,
        extraRecipesImageSize: extraRecipesImageSize,
        creatorName: creatorName,
        recipeName: recipeName,
        cremeLogoMessage: cremeLogoMessage,
        backgroundColor: backgroundColor,
        creatorAvatarSize: creatorAvatarSize,
        recipeImageSize: recipeImageSize,
        imageBackgroundSize: imageBackgroundSize,
        devicePixelRatio: devicePixelRatio,
        hasVideoOnBackground: hasVideoOnBackground,
        textScaleFactor: textScaleFactor,
        extraRecipesToShow: extraRecipesToShow,
      );
    }
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
          if (extraRecipesToShow.length >= 2)
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
                          width: recipeImageSize.width +
                              (2 * extraRecipesImageSize.width) -
                              70,
                          height: recipeImageSize.height,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  height: extraRecipesImageSize.height,
                                  width: extraRecipesImageSize.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.memory(
                                      extraRecipesToShow[0].recipeImageBytes!,
                                      height: extraRecipesImageSize.height,
                                      width: extraRecipesImageSize.width,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  height: extraRecipesImageSize.height,
                                  width: extraRecipesImageSize.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.memory(
                                      extraRecipesToShow[1].recipeImageBytes!,
                                      height: extraRecipesImageSize.height,
                                      width: extraRecipesImageSize.width,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: recipeImageSize.height,
                                  width: recipeImageSize.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.memory(
                                      recipeImageImageBytes,
                                      height: recipeImageSize.height,
                                      width: recipeImageSize.width,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 64),
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
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          creatorName,
                          style:
                              AppFonts.bodyBold.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                          textScaleFactor: textScaleFactor ??
                              MediaQuery.of(context).textScaleFactor,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          creatorTag,
                          maxLines: 2,
                          style: AppFonts.bodyRegular
                              .copyWith(color: AppColors.white50),
                          textAlign: TextAlign.center,
                          textScaleFactor: textScaleFactor ??
                              MediaQuery.of(context).textScaleFactor,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 37),
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
          if (extraRecipesToShow.length < 2)
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
                        if (extraRecipesToShow.length < 2)
                          SizedBox(
                            height: recipeImageSize.height,
                            width: recipeImageSize.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.memory(
                                recipeImageImageBytes,
                                height: recipeImageSize.height,
                                width: recipeImageSize.width,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                        if (extraRecipesToShow.length >= 2)
                          SizedBox(
                            width: recipeImageSize.width +
                                (2 * extraRecipesImageSize.width) -
                                70,
                            height: recipeImageSize.height,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: extraRecipesImageSize.height,
                                    width: extraRecipesImageSize.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.memory(
                                        extraRecipesToShow[0].recipeImageBytes!,
                                        height: extraRecipesImageSize.height,
                                        width: extraRecipesImageSize.width,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    height: extraRecipesImageSize.height,
                                    width: extraRecipesImageSize.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.memory(
                                        extraRecipesToShow[1].recipeImageBytes!,
                                        height: extraRecipesImageSize.height,
                                        width: extraRecipesImageSize.width,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: recipeImageSize.height,
                                    width: recipeImageSize.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.memory(
                                        recipeImageImageBytes,
                                        height: recipeImageSize.height,
                                        width: recipeImageSize.width,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 16),
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
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          recipeName,
                          style:
                              AppFonts.bodyBold.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                          textScaleFactor: textScaleFactor ??
                              MediaQuery.of(context).textScaleFactor,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          creatorName,
                          style: AppFonts.bodyRegular
                              .copyWith(color: AppColors.white50),
                          textAlign: TextAlign.center,
                          textScaleFactor: textScaleFactor ??
                              MediaQuery.of(context).textScaleFactor,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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

class _RecipeStickerToBackgroundVideoWidget extends StatelessWidget {
  final Uint8List? imageBackgroundImageBytes;
  final Uint8List creatorAvatarImageBytes;
  final Uint8List recipeImageImageBytes;
  final Size extraRecipesImageSize;
  final String creatorName;
  final String recipeName;
  final String cremeLogoMessage;
  final Color? backgroundColor;
  final Size creatorAvatarSize;
  final Size recipeImageSize;
  final Size imageBackgroundSize;
  final double devicePixelRatio;
  final bool hasVideoOnBackground;
  final double? textScaleFactor;
  final List<RecipeData> extraRecipesToShow;
  final String packageName = 'creme_sharing';
  final String creatorTag;

  const _RecipeStickerToBackgroundVideoWidget({
    Key? key,
    required this.imageBackgroundImageBytes,
    required this.creatorAvatarImageBytes,
    required this.recipeImageImageBytes,
    required this.extraRecipesImageSize,
    required this.creatorName,
    required this.recipeName,
    required this.cremeLogoMessage,
    required this.backgroundColor,
    required this.creatorAvatarSize,
    required this.recipeImageSize,
    required this.imageBackgroundSize,
    required this.devicePixelRatio,
    required this.hasVideoOnBackground,
    required this.textScaleFactor,
    required this.extraRecipesToShow,
    required this.creatorTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (extraRecipesToShow.length < 2) {
      final screenSize = MediaQuery.of(context).size;
      final width = screenSize.width * 261 / 375;
      return SizedBox(
        width: width,
        height: width / 0.431,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            SizedBox(
              height: recipeImageSize.width,
              width: recipeImageSize.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.memory(
                  recipeImageImageBytes,
                  height: recipeImageSize.height,
                  width: recipeImageSize.width,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              recipeName,
              style: AppFonts.bodyBold.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
              textScaleFactor:
                  textScaleFactor ?? MediaQuery.of(context).textScaleFactor,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              creatorName,
              maxLines: 2,
              style: AppFonts.bodyRegular.copyWith(color: AppColors.white50),
              textAlign: TextAlign.center,
              textScaleFactor:
                  textScaleFactor ?? MediaQuery.of(context).textScaleFactor,
              overflow: TextOverflow.ellipsis,
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
                  textScaleFactor:
                      textScaleFactor ?? MediaQuery.of(context).textScaleFactor,
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
            const SizedBox(height: 32),
          ],
        ),
      );
    }
    const carouselSize = Size(315, 260);
    return SizedBox(
      width: carouselSize.width,
      height: carouselSize.width / 0.431,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          SizedBox(
            width: carouselSize.width,
            height: carouselSize.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: extraRecipesImageSize.height,
                    width: extraRecipesImageSize.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        extraRecipesToShow[0].recipeImageBytes!,
                        height: extraRecipesImageSize.height,
                        width: extraRecipesImageSize.width,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: extraRecipesImageSize.height,
                    width: extraRecipesImageSize.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        extraRecipesToShow[1].recipeImageBytes!,
                        height: extraRecipesImageSize.height,
                        width: extraRecipesImageSize.width,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: recipeImageSize.height,
                    width: recipeImageSize.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        recipeImageImageBytes,
                        height: recipeImageSize.height,
                        width: recipeImageSize.width,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 64),
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            creatorTag,
            maxLines: 2,
            style: AppFonts.bodyRegular.copyWith(color: AppColors.white50),
            textAlign: TextAlign.center,
            textScaleFactor:
                textScaleFactor ?? MediaQuery.of(context).textScaleFactor,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 37),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                cremeLogoMessage,
                style: AppFonts.bodyRegular.copyWith(color: AppColors.white50),
                textAlign: TextAlign.center,
                textScaleFactor:
                    textScaleFactor ?? MediaQuery.of(context).textScaleFactor,
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
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class RecipeData {
  final String recipeName;
  final String recipeImageUrl;
  final Uint8List? recipeImageBytes;

  const RecipeData({
    required this.recipeName,
    required this.recipeImageUrl,
    required this.recipeImageBytes,
  });

  RecipeData copyWith({
    String? recipeName,
    String? recipeImageUrl,
    Uint8List? recipeImageBytes,
  }) {
    return RecipeData(
      recipeName: recipeName ?? this.recipeName,
      recipeImageUrl: recipeImageUrl ?? this.recipeImageUrl,
      recipeImageBytes: recipeImageBytes ?? this.recipeImageBytes,
    );
  }
}
