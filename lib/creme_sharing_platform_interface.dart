import 'dart:ui';
import 'dart:typed_data';

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

  Future<void> shareTextToInstagramDirect({
    String? text,
  }) {
    throw UnimplementedError('shareTextToWhatsapp() has not been implemented.');
  }

  Future<void> shareToInstagramStories({
    required String appId,
    Color? backgroundTopColor,
    Color? backgroundBottomColor,
    Uint8List? stickerImageBytes,
    String? backgroundVideoUrl,
    Uint8List? backgroundImageBytes,
    String? contentURL,
    Uint8List? backgroundVideoBytes,
  }) {
    throw UnimplementedError(
        'shareToInstagramStories() has not been implemented.');
  }

  Future<bool> instagramIsAvailableToShareFeed() {
    throw UnimplementedError(
        'instagramIsAvailableToShareFeed() has not been implemented.');
  }

  /// This method will share the [image] to the Instagram Feed:
  ///
  /// - **iOS**: the [image] parameter must be a [Uint8List] that will be
  /// encoded as base64 and passed to native open and share on Instagram Feed
  /// the image.
  /// - **Android**: the [image] parameter must be a [Uint8List] that will be
  /// saved locally as temporary file while you is sharing to Instagram Feed and
  /// after the file will be deleted.
  ///
  /// More information at https://developers.facebook.com/docs/instagram/sharing-to-feed
  Future<void> shareToInstagramFeed({
    required Uint8List imageBytes,
  }) {
    throw UnimplementedError(
        'shareToInstagramFeed() has not been implemented.');
  }
}
