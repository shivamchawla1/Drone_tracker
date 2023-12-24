import 'package:drone_latest/services/Get_Positions.dart';
import 'package:flutter/material.dart';
import 'package:drone_latest/pages/home.dart';
import 'package:drone_latest/pages/loading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( ChangeNotifierProvider(
    create: (context) => GetPositions(),
    child: const PlaceTracker(),
  ));
}

class PlaceTracker extends StatelessWidget {
  const PlaceTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white,
        ),
      ),
      routerConfig: GoRouter(routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Loading(),
          routes: [
            GoRoute(
              path: 'place/:id',
              builder: (context, state) {
                return Home();
              },
            ),
          ],
        ),
      ]),
    );
  }
}

