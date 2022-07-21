import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'creme_sharing_platform_interface.dart';

/// An implementation of [CremeSharingPlatform] that uses method channels.
class MethodChannelCremeSharing extends CremeSharingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('creme_sharing');

  @override
  Future<void> shareToInstagramStories({
    Color? backgroundTopColor,
    Color? backgroundBottomColor,
    String? stickerImage,
    String? backgroundVideo,
    String? backgroundImage,
    String? contentURL,
  }) async {
    if (Platform.isIOS) {
      return await methodChannel.invokeMethod(
        'shareToInstagramStories',
        {
          'backgroundTopColor': backgroundTopColor != null
              ? '#${(backgroundTopColor.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}'
              : null,
          'backgroundBottomColor': backgroundBottomColor != null
              ? '#${(backgroundBottomColor.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}'
              : null,
          'stickerImage': stickerImage,
          'backgroundVideo': backgroundVideo,
          'backgroundImage': backgroundImage,
          'contentURL': contentURL,
        },
      );
    }
    return super.shareToInstagramStories(
      contentURL: contentURL,
      backgroundTopColor: backgroundTopColor,
      backgroundBottomColor: backgroundBottomColor,
      stickerImage: stickerImage,
      backgroundVideo: backgroundVideo,
      backgroundImage: backgroundImage,
    );
  }
}
