import 'dart:math';
import 'dart:convert';
import 'dart:io' show HttpClient;
import 'dart:typed_data';

import 'package:creme_sharing/utils/cooked_sticker_widget.dart';
import 'package:creme_sharing/utils/creator_sticker_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';

import 'package:creme_sharing/creme_sharing_platform_interface.dart';
import 'package:creme_sharing/utils/recipe_sticker_widget.dart';

class CremeSharing {
  final ScreenshotController _screenshotController;
  final HttpClient _httpClient;

  CremeSharing()
      : _httpClient = HttpClient(),
        _screenshotController = ScreenshotController();

  Future<void> dispose() async {
    _httpClient.close(force: true);
  }

  /// This method will check is the user have the whatsapp available to share
  Future<bool> whatsappIsAvailableToShare() =>
      CremeSharingPlatform.instance.whatsappIsAvailableToShare();

  /// This method shares text to whatsapp
  Future<void> shareTextToWhatsapp({String? text}) =>
      CremeSharingPlatform.instance.shareTextToWhatsapp(text: text);

  /// This method will check is the user have the twitter available to share
  Future<bool> twitterIsAvailableToShare() =>
      CremeSharingPlatform.instance.twitterIsAvailableToShare();

  /// This method shares text to twitter
  Future<void> shareTextToTwitter({String? text}) =>
      CremeSharingPlatform.instance.shareTextToTwitter(text: text);

  /// This method will check is the user have the Instagram available to share
  Future<bool> instagramIsAvailableToShare() =>
      CremeSharingPlatform.instance.instagramIsAvailableToShare();

  /// All the arguments are the same of the documentation in https://developers.facebook.com/docs/sharing/sharing-to-stories
  /// but in the IOS side you can:
  /// - [backgroundTopColor] : will be transformed to a String in hex color
  /// - [backgroundBottomColor] : will be transformed to a String in hex color
  /// - [stickerImage] : will be transformed to an image if the value be a URL or an image encoded 64 as String
  /// - [backgroundImage] : will be transformed to an image if the value be an URL or an image encoded 64 as String
  /// - [backgroundVideo] : will be transformed to an image if the value be an URL
  /// - [contentURL] : it will be a string (that don't work because the app need to be a partner of Instagram)
  /// but in the Android will be implemented (WIP)
  Future<void> shareToInstagramStories({
    Color? backgroundTopColor,
    Color? backgroundBottomColor,
    String? stickerImage,
    String? backgroundVideo,
    String? backgroundImage,
    String? contentURL,
  }) =>
      CremeSharingPlatform.instance.shareToInstagramStories(
        backgroundTopColor: backgroundTopColor,
        backgroundBottomColor: backgroundBottomColor,
        stickerImage: stickerImage,
        backgroundVideo: backgroundVideo,
        backgroundImage: backgroundImage,
        contentURL: contentURL,
      );

  Future<void> shareToInstagramFeed({
    required String image,
  }) =>
      CremeSharingPlatform.instance.shareToInstagramFeed(
        image: image,
      );

  Future<void> shareToInstagramFeedUsingWidget({
    required Widget image,
    required BuildContext context,
  }) async {
    final devicePixelRatio =
        max(3, MediaQuery.of(context).devicePixelRatio).toDouble();
    final imagePngBytes = await _screenshotController.captureFromWidget(
      image,
      pixelRatio: devicePixelRatio,
      context: context,
    );
    CremeSharingPlatform.instance.shareToInstagramFeed(
      image: base64Encode(imagePngBytes),
    );
  }

  /// All the arguments are the same of the documentation in https://developers.facebook.com/docs/sharing/sharing-to-stories
  /// but in the IOS side you can:
  /// - [backgroundTopColor] : will be transformed to a String in hex color
  /// - [backgroundBottomColor] : will be transformed to a String in hex color
  /// - [stickerImage] : will be transformed to an image if the value be a URL or an image encoded 64 as String
  /// - [backgroundImage] : will be transformed to an image if the value be an URL or an image encoded 64 as String
  /// - [backgroundVideo] : will be transformed to an image if the value be an URL
  /// - [contentURL] : it will be a string (that don't work because the app need to be a partner of Instagram)
  /// but in the Android will be implemented (WIP)
  Future<void> shareToInstagramStoriesUsingWidgets({
    Color? backgroundTopColor,
    Color? backgroundBottomColor,
    Widget? stickerImage,
    String? backgroundVideo,
    Widget? backgroundImage,
    String? contentURL,
    required BuildContext context,
  }) async {
    final devicePixelRatio =
        max(3, MediaQuery.of(context).devicePixelRatio).toDouble();
    final imagesPngBytes = await Future.wait([
      if (stickerImage != null)
        _screenshotController.captureFromWidget(
          stickerImage,
          pixelRatio: devicePixelRatio,
          context: context,
        ),
      if (backgroundImage != null)
        _screenshotController.captureFromWidget(
          backgroundImage,
          pixelRatio: devicePixelRatio,
          context: context,
        ),
    ]);
    final stickerImagePngBytes =
        stickerImage != null ? imagesPngBytes.first : null;
    final backgroundImagePngBytes =
        backgroundImage != null ? imagesPngBytes.last : null;
    CremeSharingPlatform.instance.shareToInstagramStories(
      backgroundTopColor: backgroundTopColor,
      backgroundBottomColor: backgroundBottomColor,
      stickerImage: stickerImagePngBytes != null
          ? base64Encode(stickerImagePngBytes)
          : null,
      backgroundVideo: backgroundVideo,
      backgroundImage: backgroundImagePngBytes != null
          ? base64Encode(backgroundImagePngBytes)
          : null,
      contentURL: contentURL,
    );
  }

  /// This method should be used to share some creator to Instagram stories
  /// and the mockup can be found on: https://www.figma.com/file/r5ox3y5gRNFXPDb1KcsQS3/CREME-2022?node-id=2316%3A217770
  /// Then it will create an image and othe background will be the [backgroundVideoUrl]
  /// if that's not null else will be render [creatorAvatarUrl] as background image.
  Future<void> shareCreatorToInstagramStories({
    required String creatorAvatarUrl,
    required String creatorName,
    required String cremeLogoMessage,
    required String creatorTag,
    required BuildContext context,
    required String? backgroundVideoUrl,
    Color backgroundColor = Colors.grey,
    double textScaleFactor = 1,
    String? contentURL,
  }) async {
    final devicePixelRatio =
        max(3, MediaQuery.of(context).devicePixelRatio).toDouble();
    final screenSize = MediaQuery.of(context).size;
    final safeAreaPadding = MediaQuery.of(context).padding;
    final maxHeight = screenSize.height - safeAreaPadding.vertical - 48;
    final maxWidth = screenSize.width;
    const avatarSize = Size(40, 40);
    const extraRecipesImageSize = Size(108, 155);
    final imageBackgroundSize = Size(maxWidth, maxHeight);
    final hasVideoOnBackground = backgroundVideoUrl != null;
    final imageBackgroundUrlToDownload = '$creatorAvatarUrl'
        '?w=${(devicePixelRatio * imageBackgroundSize.width).round()}'
        '&h=${(devicePixelRatio * imageBackgroundSize.width).round()}';
    final creatorAvatarUrlToDownload = '$creatorAvatarUrl'
        '?w=${(devicePixelRatio * avatarSize.width).round()}'
        '&h=${(devicePixelRatio * avatarSize.width).round()}';
    final imageBytes = await Future.wait([
      downloadImage(url: creatorAvatarUrlToDownload),
      if (!hasVideoOnBackground)
        downloadImage(url: imageBackgroundUrlToDownload),
    ]);
    final stickerImagePngBytes = await _screenshotController.captureFromWidget(
      CreatorStickerWidget(
        extraRecipesImageSize: extraRecipesImageSize,
        textScaleFactor: textScaleFactor,
        hasVideoOnBackground: hasVideoOnBackground,
        creatorAvatarImageBytes: imageBytes[0]!,
        imageBackgroundImageBytes:
            imageBytes.length >= 2 ? imageBytes.last : null,
        imageBackgroundSize: imageBackgroundSize,
        creatorAvatarSize: avatarSize,
        creatorTag: creatorTag,
        backgroundColor: backgroundColor,
        creatorName: creatorName,
        cremeLogoMessage: cremeLogoMessage,
        devicePixelRatio: devicePixelRatio,
      ),
      pixelRatio: devicePixelRatio,
      context: context,
    );
    await shareToInstagramStories(
      backgroundImage:
          hasVideoOnBackground ? null : base64Encode(stickerImagePngBytes),
      stickerImage:
          hasVideoOnBackground ? base64Encode(stickerImagePngBytes) : null,
      backgroundTopColor: backgroundColor,
      backgroundBottomColor: backgroundColor,
      contentURL: contentURL,
      backgroundVideo: backgroundVideoUrl,
    );
  }

  /// This method should be used to share some recipe to Instagram stories
  /// and the mockup can be found on:
  /// 1. one recipe : https://www.figma.com/file/r5ox3y5gRNFXPDb1KcsQS3/CREME-2022?node-id=2316%3A217803;
  /// 2. three recipes : https://www.figma.com/file/r5ox3y5gRNFXPDb1KcsQS3/CREME-2022?node-id=2316%3A217730;
  /// Then it will create an image and othe background will be the [backgroundVideoUrl]
  /// if that's not null else will be render [recipeImageUrl] as background image.
  /// You should provide the [recipeImageUrl] that will positioned in the center and the
  /// [extraRecipesToShow] will be positioned on the left and right.
  Future<void> shareRecipesToInstagramStories({
    required String creatorAvatarUrl,
    required String recipeImageUrl,
    required String creatorName,
    required String recipeName,
    required String cremeLogoMessage,
    required String creatorTag,
    required BuildContext context,
    required String? backgroundVideoUrl,
    required List<RecipeData> extraRecipesToShow,
    Color backgroundColor = Colors.grey,
    double textScaleFactor = 1,
    String? contentURL,
  }) async {
    final devicePixelRatio =
        max(3, MediaQuery.of(context).devicePixelRatio).toDouble();
    final screenSize = MediaQuery.of(context).size;
    final safeAreaPadding = MediaQuery.of(context).padding;
    final maxHeight = screenSize.height - safeAreaPadding.vertical - 48;
    final maxWidth = screenSize.width;
    final hasVideoOnBackground = backgroundVideoUrl != null;
    const avatarSize = Size(40, 40);
    final recipeImageSize = extraRecipesToShow.length < 2
        ? const Size(261, 261)
        : const Size(165, 260);
    const extraRecipesImageSize = Size(108, 155);
    final imageBackgroundSize = Size(maxWidth, maxHeight);
    final imageBackgroundUrlToDownload = '$recipeImageUrl'
        '?w=${(devicePixelRatio * imageBackgroundSize.width).round()}'
        '&h=${(devicePixelRatio * imageBackgroundSize.width).round()}';
    final creatorAvatarUrlToDownload = '$creatorAvatarUrl'
        '?w=${(devicePixelRatio * avatarSize.width).round()}'
        '&h=${(devicePixelRatio * avatarSize.width).round()}';
    final recipeImageUrlToDownload = '$recipeImageUrl'
        '?w=${(devicePixelRatio * recipeImageSize.width).round()}'
        '&h=${(devicePixelRatio * recipeImageSize.width).round()}';
    final imageBytes = await Future.wait([
      downloadImage(url: creatorAvatarUrlToDownload),
      downloadImage(url: recipeImageUrlToDownload),
      if (!hasVideoOnBackground)
        downloadImage(url: imageBackgroundUrlToDownload),
      ...List.of(extraRecipesToShow)
          .take(2)
          .map<Future>((recipeData) => downloadImage(
                url: '${recipeData.recipeImageUrl}'
                    '?w=${(devicePixelRatio * extraRecipesImageSize.width).round()}'
                    '&h=${(devicePixelRatio * extraRecipesImageSize.width).round()}',
              ).then(
                (value) {
                  if (value != null) {
                    final index = extraRecipesToShow.indexOf(recipeData);
                    extraRecipesToShow[index] = extraRecipesToShow[index]
                        .copyWith(recipeImageBytes: value);
                  }
                },
              ))
          .toList(),
    ]);
    final stickerImagePngBytes = await _screenshotController.captureFromWidget(
      RecipeStickerWidget(
        creatorTag: creatorTag,
        extraRecipesImageSize: extraRecipesImageSize,
        textScaleFactor: textScaleFactor,
        hasVideoOnBackground: hasVideoOnBackground,
        creatorAvatarImageBytes: imageBytes[0]!,
        recipeImageImageBytes: imageBytes[1]!,
        imageBackgroundImageBytes:
            imageBytes.length >= 3 ? imageBytes[2] : null,
        extraRecipesToShow: List.of(extraRecipesToShow)
            .where((recipeData) => recipeData.recipeImageBytes != null)
            .take(2)
            .toList(),
        recipeImageSize: recipeImageSize,
        imageBackgroundSize: imageBackgroundSize,
        creatorAvatarSize: avatarSize,
        recipeName: recipeName,
        backgroundColor: backgroundColor,
        creatorName: creatorName,
        cremeLogoMessage: cremeLogoMessage,
        devicePixelRatio: devicePixelRatio,
      ),
      pixelRatio: devicePixelRatio,
      context: context,
    );
    await shareToInstagramStories(
      backgroundImage:
          hasVideoOnBackground ? null : base64Encode(stickerImagePngBytes),
      stickerImage:
          hasVideoOnBackground ? base64Encode(stickerImagePngBytes) : null,
      backgroundTopColor: backgroundColor,
      backgroundBottomColor: backgroundColor,
      contentURL: contentURL,
      backgroundVideo: backgroundVideoUrl,
    );
  }

  /// This method should be used to share some cooked recipe to Instagram stories
  /// and the mockup can be found on: https://www.figma.com/file/r5ox3y5gRNFXPDb1KcsQS3/CREME-2022?node-id=2316%3A217838
  ///
  /// Then it will create an image and othe background will be the [backgroundVideoUrl]
  /// if that's not null else will be render [creatorAvatarUrl] as background image
  Future<void> shareCookedToInstagramStories({
    required String userName,
    required String? userAvatarUrl,
    required String cookedImageUrl,
    required String creatorAvatarUrl,
    required String creatorName,
    required String recipeName,
    required String cremeLogoMessage,
    required BuildContext context,
    required String? backgroundVideoUrl,
    Color backgroundColor = Colors.grey,
    double textScaleFactor = 1,
    String? contentURL,
  }) async {
    final devicePixelRatio =
        max(3, MediaQuery.of(context).devicePixelRatio).toDouble();
    final screenSize = MediaQuery.of(context).size;
    final safeAreaPadding = MediaQuery.of(context).padding;
    final hasVideoOnBackground = backgroundVideoUrl != null;
    final maxHeight = screenSize.height - safeAreaPadding.vertical - 48;
    final maxWidth = screenSize.width;
    const avatarSize = Size(40, 40);
    const cookedImageSize = Size(261, 261);
    final imageBackgroundSize = Size(maxWidth, maxHeight);
    final imageBackgroundUrlToDownload = '$creatorAvatarUrl'
        '?w=${(devicePixelRatio * imageBackgroundSize.width).round()}'
        '&h=${(devicePixelRatio * imageBackgroundSize.width).round()}';
    final creatorAvatarUrlToDownload = '$creatorAvatarUrl'
        '?w=${(devicePixelRatio * avatarSize.width).round()}'
        '&h=${(devicePixelRatio * avatarSize.width).round()}';
    final cookedImageUrlToDownload = '$cookedImageUrl'
        '?w=${(devicePixelRatio * cookedImageSize.width).round()}'
        '&h=${(devicePixelRatio * cookedImageSize.height).round()}';
    final userAvatarUrlToDownload = userAvatarUrl != null
        ? '$userAvatarUrl'
            '?w=${(devicePixelRatio * avatarSize.width).round()}'
            '&h=${(devicePixelRatio * avatarSize.width).round()}'
        : null;
    final imageBytes = await Future.wait([
      downloadImage(url: creatorAvatarUrlToDownload),
      downloadImage(url: cookedImageUrlToDownload),
      if (userAvatarUrlToDownload != null)
        downloadImage(url: userAvatarUrlToDownload),
      if (!hasVideoOnBackground)
        downloadImage(url: imageBackgroundUrlToDownload),
    ]);
    final stickerImagePngBytes = await _screenshotController.captureFromWidget(
      CookedStickerWidget(
        textScaleFactor: textScaleFactor,
        hasVideoOnBackground: hasVideoOnBackground,
        imageBackgroundImageBytes:
            imageBytes.length >= 3 ? imageBytes.last : null,
        creatorAvatarImageBytes: imageBytes[0]!,
        cookedImageBytes: imageBytes[1]!,
        userAvatarImageBytes:
            imageBytes.length >= 3 && userAvatarUrlToDownload != null
                ? imageBytes[2]
                : null,
        cookedImageSize: cookedImageSize,
        imageBackgroundSize: imageBackgroundSize,
        userAvatarSize: avatarSize,
        creatorAvatarSize: avatarSize,
        userName: userName,
        recipeName: recipeName,
        backgroundColor: backgroundColor,
        creatorName: creatorName,
        cremeLogoMessage: cremeLogoMessage,
        devicePixelRatio: devicePixelRatio,
      ),
      pixelRatio: devicePixelRatio,
      context: context,
    );
    await shareToInstagramStories(
      backgroundImage:
          hasVideoOnBackground ? null : base64Encode(stickerImagePngBytes),
      stickerImage:
          hasVideoOnBackground ? base64Encode(stickerImagePngBytes) : null,
      backgroundTopColor: backgroundColor,
      backgroundBottomColor: backgroundColor,
      contentURL: contentURL,
      backgroundVideo: backgroundVideoUrl,
    );
  }

  Future<Uint8List?> downloadImage({
    required String url,
  }) async {
    try {
      final request = await _httpClient.getUrl(Uri.parse(url));
      final response = await request.close();
      final bytes = await consolidateHttpClientResponseBytes(
        response,
        autoUncompress: true,
      );
      return bytes;
    } catch (err) {
      rethrow;
    }
  }
}
