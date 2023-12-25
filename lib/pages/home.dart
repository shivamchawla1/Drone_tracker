import 'package:drone_latest/pages/place_map.dart';
import 'package:drone_latest/Models/Get_Positions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  // final Place place;
  // const Home({
  //   required this.place,
  //   super.key,
  // });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<GetPositions>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Drone Tracker'),
        centerTitle: true,
        elevation: 0,
      ),
      body: IndexedStack(
        children: const [
          PlaceMap(center: LatLng(45.521563, -122.677433)),
          // PlaceList()
        ],
      ),
    );
  }
}
