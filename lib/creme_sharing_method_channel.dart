import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'creme_sharing_platform_interface.dart';

/// An implementation of [CremeSharingPlatform] that uses method channels.
class MethodChannelCremeSharing extends CremeSharingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('creme_sharing');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
