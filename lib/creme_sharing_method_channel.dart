import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'creme_sharing_platform_interface.dart';

/// An implementation of [CremeSharingPlatform] that uses method channels.
class MethodChannelCremeSharing extends CremeSharingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('creme_sharing');

  @override
  Future<bool> instagramIsAvailableToShare() async {
    return (await methodChannel
            .invokeMethod<bool>('instagramIsAvailableToShare') ??
        false);
  }

  @override
  Future<bool> whatsappIsAvailableToShare() async {
    return (await methodChannel
            .invokeMethod<bool>('whatsappIsAvailableToShare') ??
        false);
  }

  @override
  Future<bool> twitterIsAvailableToShare() async {
    return (await methodChannel
            .invokeMethod<bool>('twitterIsAvailableToShare') ??
        false);
  }

  @override
  Future<void> shareTextToTwitter({String? text}) async {
    return await methodChannel.invokeMethod('shareTextToTwitter', {
      'message': text,
    });
  }

  @override
  Future<void> shareTextToWhatsapp({String? text}) async {
    return await methodChannel.invokeMethod(
      'shareTextToWhatsapp',
      {
        'message': text,
      },
    );
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
  @override
  Future<void> shareToInstagramStories({
    required String appId,
    Color? backgroundTopColor,
    Color? backgroundBottomColor,
    Uint8List? stickerImageBytes,
    String? backgroundVideoUrl,
    Uint8List? backgroundImageBytes,
    String? contentURL,
    Uint8List? backgroundVideoBytes,
  }) async {
    if (Platform.isIOS) {
      return await methodChannel.invokeMethod(
        'shareToInstagramStories',
        {
          'appId': appId,
          'backgroundTopColor': backgroundTopColor != null
              ? '#${(backgroundTopColor.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}'
              : null,
          'backgroundBottomColor': backgroundBottomColor != null
              ? '#${(backgroundBottomColor.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}'
              : null,
          'stickerImage': stickerImageBytes != null
              ? base64Encode(stickerImageBytes)
              : null,
          'backgroundVideo': backgroundVideoUrl,
          'backgroundImage': backgroundImageBytes != null
              ? base64Encode(backgroundImageBytes)
              : null,
          'contentURL': contentURL,
        },
      );
    }

    if (Platform.isAndroid) {
      final temporaryDirectory = await getTemporaryDirectory();
      final targetNameBackgroundFile = DateTime.now().millisecondsSinceEpoch;
      final targetNameStickerFile = DateTime.now().millisecondsSinceEpoch;
      final files = await Future.wait([
        () async {
          if (backgroundVideoBytes != null) {
            return await File(
                    '${temporaryDirectory.path}/$targetNameBackgroundFile.mp4')
                .writeAsBytes(backgroundVideoBytes);
          }

          if (backgroundImageBytes != null) {
            return await File(
                    '${temporaryDirectory.path}/$targetNameBackgroundFile.png')
                .writeAsBytes(backgroundImageBytes);
          }
          return null;
        }(),
        () async {
          if (stickerImageBytes != null) {
            return await File(
                    '${temporaryDirectory.path}/$targetNameStickerFile.png')
                .writeAsBytes(stickerImageBytes);
          }
          return null;
        }(),
      ]);
      final backgroundFile = files.first;
      final interactiveFile = files.last;
      await methodChannel.invokeMethod(
        'shareToInstagramStories',
        {
          'backgroundAssetPath': backgroundFile?.path,
          'backgroundAssetType': () {
            if (backgroundVideoBytes != null) {
              return 'video/*';
            }

            if (backgroundImageBytes != null) {
              return 'image/*';
            }
            return null;
          }(),
          'sourceApplication': appId,
          'topBackgroundColor': backgroundTopColor != null
              ? '#${(backgroundTopColor.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}'
              : null,
          'bottomBackgroundColor': backgroundBottomColor != null
              ? '#${(backgroundBottomColor.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}'
              : null,
          'interactiveAssetPath': interactiveFile?.path,
        },
      );
      await Future.wait([
        if (backgroundFile != null) backgroundFile.delete(),
        if (interactiveFile != null) interactiveFile.delete(),
      ]);
      return;
    }

    return super.shareToInstagramStories(
      appId: appId,
      contentURL: contentURL,
      backgroundTopColor: backgroundTopColor,
      backgroundBottomColor: backgroundBottomColor,
      stickerImageBytes: stickerImageBytes,
      backgroundVideoUrl: backgroundVideoUrl,
      backgroundImageBytes: backgroundImageBytes,
    );
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
  @override
  Future<void> shareToInstagramFeed({
    required Uint8List imageBytes,
  }) async {
    if (Platform.isIOS) {
      return await methodChannel.invokeMethod(
        'shareToInstagramFeed',
        {'image': base64Encode(imageBytes)},
      );
    }
    if (Platform.isAndroid) {
      final temporaryDirectory = await getTemporaryDirectory();
      final targetName = DateTime.now().millisecondsSinceEpoch;
      final imageFile = await File('${temporaryDirectory.path}/$targetName.png')
          .writeAsBytes(imageBytes);
      await methodChannel.invokeMethod(
        'shareToInstagramFeed',
        {
          'imageAssetPath': imageFile.path,
          'imageAssetType': 'image/*',
        },
      );
      await imageFile.delete();
      return;
    }
    return super.shareToInstagramFeed(imageBytes: imageBytes);
  }

  @override
  Future<bool> instagramIsAvailableToShareFeed() async {
    return await methodChannel.invokeMethod('instagramIsAvailableToShareFeed');
  }
}
