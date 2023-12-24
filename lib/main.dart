import 'package:drone_latest/services/Get_Positions.dart';
import 'package:flutter/material.dart';
import 'package:drone_latest/pages/home.dart';
import 'package:drone_latest/pages/loading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'pages/place_tracker.dart';

void main() {
  runApp( ChangeNotifierProvider(
    create: (context) => GetPositions(),
    child: const PlaceTracker(),
  ));
}

