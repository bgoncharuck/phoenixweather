import 'package:permission_handler/permission_handler.dart';
export 'package:permission_handler/permission_handler.dart';

Map<Permission, PermissionStatus> statusOf;
Future get requestPermissions async => statusOf = await [
  Permission.storage,
].request();