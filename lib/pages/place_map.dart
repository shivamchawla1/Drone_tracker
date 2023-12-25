// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../Models/Get_Positions.dart';

class MapConfiguration {
  final List<Place> places;

  const MapConfiguration({
    required this.places,
  });

  @override
  int get hashCode => places.hashCode ;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is MapConfiguration &&
        other.places == places;
  }

  static MapConfiguration of(GetPositions getPositions) {
    return MapConfiguration(
      places: getPositions.places,
    );
  }
}

class PlaceMap extends StatefulWidget {
  final LatLng? center;

  const PlaceMap({
    super.key,
    this.center,
  });

  @override
  State<PlaceMap> createState() => _PlaceMapState();
}

class _PlaceMapState extends State<PlaceMap> {
  Completer<GoogleMapController> mapController = Completer();

  Location _locationController = new Location();

  MapType _currentMapType = MapType.normal;

  LatLng? _lastMapPosition;
  LatLng? _currentPosition = null;

  final Map<Marker, Place> _markedPlaces = <Marker, Place>{};

  final Set<Marker> _markers = {};

  MapConfiguration? _configuration;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<GetPositions>(context, listen: true);
    return Builder(builder: (context) {
      // We need this additional builder here so that we can pass its context to
      // _AddPlaceButtonBar's onSavePressed callback. This callback shows a
      // SnackBar and to do this, we need a build context that has Scaffold as
      // an ancestor.
      return Center(
        child: _currentPosition == null ?
        const Text("Loading..") :
        Stack(
          children: [
            GoogleMap(
              onMapCreated: ((GoogleMapController controller) => mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 15.0,
              ),
              mapType: _currentMapType,
              markers: {
                Marker(markerId:  MarkerId("_currentLocation"),icon: BitmapDescriptor.defaultMarker , position: _currentPosition!)
              },
              onCameraMove: (position) => _lastMapPosition = position.target,
            ),
          ],
        ),
      );
    });
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);
    _lastMapPosition = widget.center;
  }

  @override
  void didUpdateWidget(PlaceMap oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();

    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else{
      return;
    }
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.longitude != null && currentLocation.latitude != null) {
        setState(() {
          _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _cameraToPosition(_currentPosition!);

        });
      }

    });
  }
  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos , zoom: 15.0);
    await controller.animateCamera(CameraUpdate.newCameraPosition(_newCameraPosition));
  }

}
