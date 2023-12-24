import 'package:drone_latest/services/Get_Positions.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: Colors.blue[900],
        title: Text('Drone Tracker'),
        centerTitle: true,
        elevation: 0,
      ),
      body: IndexedStack(
        index: state.viewType == PlaceTrackerViewType.map ? 0 : 1,
        children: const [
          // PlaceMap(center: LatLng(45.521563, -122.677433)),
          // PlaceList()
        ],
      ),
    );
  }
}
