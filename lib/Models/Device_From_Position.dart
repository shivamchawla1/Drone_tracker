import 'Position_Model.dart';
import 'package:drone_latest/Models/Device_Model.dart';

/// Get a device from a traccar position
Device deviceFromPosition(Map<String, dynamic> data,
    {String timeZoneOffset = "0",
      Duration keepAlive = const Duration(minutes: 1)}) {
  return Device(
      id: int.parse(data["deviceId"].toString()),
      keepAlive: keepAlive,
      position: DevicePosition.fromJson(data, timeZoneOffset: timeZoneOffset)
          .geoPoint,
      batteryLevel:
      double.parse(data["attributes"]["batteryLevel"].toString()));
}
