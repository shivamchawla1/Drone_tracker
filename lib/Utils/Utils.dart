import 'dart:ui';
import 'package:flutter/services.dart';


DateTime dateFromUtcOffset(String dateStr, String timeZoneOffset) {
  DateTime d = DateTime.parse(dateStr);
  if (timeZoneOffset.startsWith("+")) {
    final of = int.parse(timeZoneOffset.replaceFirst("+", ""));
    d = d.add(Duration(hours: of));
  } else if (timeZoneOffset.startsWith("-")) {
    final of = int.parse(timeZoneOffset.replaceFirst("-", ""));
    d = d.subtract(Duration(hours: of));
  }
  return d;
}
Future<Uint8List?> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))?.buffer.asUint8List();
}