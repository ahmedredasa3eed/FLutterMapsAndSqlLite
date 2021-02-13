import 'package:flutter/material.dart';
import 'package:nativefeatures/providers/place_provider.dart';
import 'package:nativefeatures/screens/add_place_screen.dart';
import 'package:nativefeatures/screens/map_screen.dart';
import 'package:nativefeatures/screens/place_details_screen.dart';
import 'package:nativefeatures/screens/places_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlaceProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.lightGreen,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesScreen(),
        routes: {
          NewPlaceScreen.route : (context) => NewPlaceScreen(),
          MapsScreen.route : (context) => MapsScreen(),
          PlaceDetails.route : (context) => PlaceDetails(),
        },
      ),
    );
  }
}

