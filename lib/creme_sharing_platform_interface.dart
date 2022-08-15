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

  Future<bool> whatsappIsAvailableToShare() {
    throw UnimplementedError(
        'whatsappIsAvailableToShare() has not been implemented.');
  }

  Future<bool> instagramIsAvailableToShare() {
    throw UnimplementedError(
        'instagramIsAvailableToShare() has not been implemented.');
  }

  Future<bool> twitterIsAvailableToShare() {
    throw UnimplementedError(
        'twitterIsAvailableToShare() has not been implemented.');
  }

  Future<void> shareTextToTwitter({
    String? text,
  }) {
    throw UnimplementedError('shareTextToTwitter() has not been implemented.');
  }

  Future<void> shareTextToWhatsapp({
    String? text,
  }) {
    throw UnimplementedError('shareTextToWhatsapp() has not been implemented.');
  }

  Future<void> shareToInstagramStories({
    Color? backgroundTopColor,
    Color? backgroundBottomColor,
    String? stickerImage,
    String? backgroundVideo,
    String? backgroundImage,
    String? contentURL,
  }) {
    throw UnimplementedError(
        'shareToInstagramStories() has not been implemented.');
  }
}
