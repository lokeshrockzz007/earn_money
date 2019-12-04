import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  getPermissions() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([
      PermissionGroup.contacts,
      PermissionGroup.sms,
      PermissionGroup.location,
      PermissionGroup.camera,
      PermissionGroup.microphone,
      PermissionGroup.storage
    ]);
    print(permissions);
  }
}
