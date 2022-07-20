import 'package:flutter_test/flutter_test.dart';
import 'package:creme_sharing/creme_sharing.dart';
import 'package:creme_sharing/creme_sharing_platform_interface.dart';
import 'package:creme_sharing/creme_sharing_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCremeSharingPlatform 
    with MockPlatformInterfaceMixin
    implements CremeSharingPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CremeSharingPlatform initialPlatform = CremeSharingPlatform.instance;

  test('$MethodChannelCremeSharing is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCremeSharing>());
  });

  test('getPlatformVersion', () async {
    CremeSharing cremeSharingPlugin = CremeSharing();
    MockCremeSharingPlatform fakePlatform = MockCremeSharingPlatform();
    CremeSharingPlatform.instance = fakePlatform;
  
    expect(await cremeSharingPlugin.getPlatformVersion(), '42');
  });
}
