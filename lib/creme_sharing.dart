import 'dart:ui';

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
}
