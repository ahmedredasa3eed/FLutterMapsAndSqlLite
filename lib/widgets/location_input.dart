import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nativefeatures/helpers/location_helper.dart';
import 'package:nativefeatures/screens/map_screen.dart';

class LocationInput extends StatefulWidget {

  final Function _onSelectAddress;

  LocationInput(this._onSelectAddress);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String previewMapImageUrl;

  Future<void> _getCurrentUserLocation() async {

    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    final _previewImage = LocationHelper.generateMapPreviewImageUrl(
        _locationData.latitude, _locationData.longitude);
    setState(() {
      previewMapImageUrl = _previewImage;
    });

    widget._onSelectAddress(_locationData.latitude, _locationData.longitude);

  }

  void _selectOnMap() async {
      final LatLng response = await Navigator.push(context, MaterialPageRoute(fullscreenDialog: true, builder: (context) => MapsScreen()));

      if (response == null) {
        return;
      }
      widget._onSelectAddress(response.latitude, response.longitude);

      final _previewImage = LocationHelper.generateMapPreviewImageUrl(
          response.latitude, response.longitude);
      setState(() {
        previewMapImageUrl = _previewImage;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          child: previewMapImageUrl == null
              ? Text("No Location Found")
              : Image.network(
                  previewMapImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text("Current Location"),
            ),
            FlatButton.icon(
              onPressed:_selectOnMap,
              icon: Icon(Icons.map),
              label: Text("Select Location on Map"),
            ),
          ],
        ),
      ],
    );
  }
}
