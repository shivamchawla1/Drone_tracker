import 'package:flutter/material.dart';
import 'package:drone_latest/Models/Get_Positions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';


class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getAllDevices() async {
    Future.delayed(Duration(milliseconds: 2000), () {
      // Do something
      context.pushReplacement('/place/:id');
    });

  }

  @override
  void initState() {
    super.initState();
    getAllDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
            child: SpinKitFadingCube(
              color: Colors.white,
              size: 50.0,
            )
        )
    );
  }
}

