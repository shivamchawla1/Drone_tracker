import 'package:drone_latest/Models/Get_Positions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'pages/place_tracker.dart';

void main() {
  runApp( ChangeNotifierProvider(
    create: (context) => GetPositions(places: {
      Place(id: "1", latLng: LatLng(1.0, 1.0)),
    }.toList()),
    child: const PlaceTracker(),
  ));
}

