
import 'creme_sharing_platform_interface.dart';

class CremeSharing {
  Future<String?> getPlatformVersion() {
    return CremeSharingPlatform.instance.getPlatformVersion();
  }
}
