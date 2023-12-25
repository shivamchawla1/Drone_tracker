import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetPositions extends ChangeNotifier {

  GetPositions({
    required this.places,
  });

  List<Place> places;

  void setPlaces(List<Place> newPlaces) {
    places = newPlaces;
    notifyListeners();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetPositions &&
        other.places == places;
  }

  @override
  int get hashCode => places.hashCode;
}

class Place {

  final String id;
  final LatLng latLng;

  const Place({
    required this.id,
    required this.latLng,
  });

  double get latitude => latLng.latitude;

  double get longitude => latLng.longitude;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Place &&
              id == other.id &&
              latLng == other.latLng;

  @override
  int get hashCode =>
      id.hashCode ^
      latLng.hashCode;
}


