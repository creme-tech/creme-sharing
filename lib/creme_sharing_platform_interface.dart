import 'dart:ui';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'creme_sharing_method_channel.dart';

abstract class CremeSharingPlatform extends PlatformInterface {
  /// Constructs a CremeSharingPlatform.
  CremeSharingPlatform() : super(token: _token);

  static final Object _token = Object();

  static CremeSharingPlatform _instance = MethodChannelCremeSharing();

  /// The default instance of [CremeSharingPlatform] to use.
  ///
  /// Defaults to [MethodChannelCremeSharing].
  static CremeSharingPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CremeSharingPlatform] when
  /// they register themselves.
  static set instance(CremeSharingPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> shareToInstagramStories({
    Color? backgroundTopColor,
    Color? backgroundBottomColor,
    String? stickerImage,
    String? backgroundVideo,
    String? backgroundImage,
    String? contentURL,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
