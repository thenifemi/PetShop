import 'package:geolocation/geolocation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {

  // Allows request any permission in the Permission Group with this method
  static Future<bool> requestPermission(PermissionGroup permission) async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    _permissionHandler.shouldShowRequestPermissionRationale(permission);
    final result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  // Allows checks on any permission in the Permission Group with this method
  static Future<bool> hasPermission(PermissionGroup permission) async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var permissionStatus = await _permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }

  //below is about gps and location services checks

  static Future<bool> isGpsServiceActive() async {
    final GeolocationResult gps = await Geolocation.isLocationOperational();
    if(!gps.isSuccessful) {
      await Geolocation.enableLocationServices()
          .then((GeolocationResult onValue) async {
        if (onValue.isSuccessful) return true;
        else return false;
      });
    }
    return true;
  }

  static Future<bool> isLocationServiceAndPermissionsActive() async {
    final GeolocationResult gpsServiceActive = await Geolocation.isLocationOperational();
    final gpsPermissionGranted = await PermissionUtil.hasPermission(PermissionGroup.locationWhenInUse);

    if(gpsServiceActive.isSuccessful == false || gpsPermissionGranted == false)
      return false;

    return true;
  }
}
