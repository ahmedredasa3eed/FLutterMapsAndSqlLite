import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:nativefeatures/helpers/location_helper.dart';

class MapsScreen extends StatefulWidget {

  //bool isSelecting;
  //MapsScreen({this.isSelecting});

  static const route = 'maps-screen';

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng _pickedLocation;

  void _selectLocationOnMap(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  List<LatLng> points =  [LatLng(21.6191283, 39.19181),LatLng(21.6141283, 39.19180)];

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2)async{
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude}, ${l2.longitude}&key=$GOOGLE_MAP_API_KEY";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return  values["routes"][0]["overview_polyline"]["points"];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select your Location"),
        actions: _pickedLocation == null
            ? null
            : [
                IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      Navigator.of(context).pop(_pickedLocation);
                    }),
              ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(21.6191283, 39.19181),
          zoom: 18,
        ),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onTap:  _selectLocationOnMap,
        markers: _pickedLocation == null
            ? null
            : {
                Marker(
                    markerId: MarkerId('m1'),
                    position: _pickedLocation,
                    draggable: true,
                    infoWindow: InfoWindow(
                    title: "This is my location!"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(30),
                ),

              },
      ),
    );
  }
}
