import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import 'package:creme_sharing/utils/creator_sticker_widget.dart';
import 'creme_sharing_platform_interface.dart';

class CremeSharing {
  const CremeSharing();

  Future<void> shareToInstagramStories({
    Color? backgroundTopColor,
    Color? backgroundBottomColor,
    String? stickerImage,
    String? backgroundVideo,
    String? backgroundImage,
    String? contentURL,
  }) {
    return CremeSharingPlatform.instance.shareToInstagramStories(
      backgroundTopColor: backgroundTopColor,
      backgroundBottomColor: backgroundBottomColor,
      stickerImage: stickerImage,
      backgroundVideo: backgroundVideo,
      backgroundImage: backgroundImage,
      contentURL: contentURL,
    );
  }

  Future<void> shareCreatorToInstagramStories({
    required String creatorAvatarUrl,
    required String creatorName,
    required String creatorTag,
    required String cremeLogoMessage,
    required BuildContext context,
    Color backgroundColor = Colors.grey,
    String? contentURL,
  }) async {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final creatorAvatarImage =
        (await NetworkAssetBundle(Uri.parse(creatorAvatarUrl)).load(''))
            .buffer
            .asUint8List();
    final stickerImagePngBytes = await ScreenshotController().captureFromWidget(
      CreatorStickerWidget(
        backgroundColor: backgroundColor,
        creatorAvatarImage: creatorAvatarImage,
        creatorName: creatorName,
        creatorTag: creatorTag,
        cremeLogoMessage: cremeLogoMessage,
      ),
      pixelRatio: devicePixelRatio,
      context: context,
    );
    final stickerImageBase64 = base64Encode(stickerImagePngBytes);
    await shareToInstagramStories(
      backgroundImage: stickerImageBase64,
      backgroundTopColor: backgroundColor,
      backgroundBottomColor: backgroundColor,
      // stickerImage: stickerImageBase64,
    );
  }
}
