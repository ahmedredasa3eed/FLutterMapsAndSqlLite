import 'package:flutter/material.dart';
import 'package:nativefeatures/helpers/location_helper.dart';
import 'package:nativefeatures/models/place.dart';
import 'package:nativefeatures/providers/place_provider.dart';
import 'package:provider/provider.dart';

class PlaceDetails extends StatelessWidget {

  static const route = "place-details";
  @override
  Widget build(BuildContext context) {

    final placeData = ModalRoute.of(context).settings.arguments as Place;


    final previewMapImageUrl = LocationHelper.generateMapPreviewImageUrl(
        placeData.location.latitude, placeData.location.longitude);

    return Scaffold(
      appBar: AppBar(
        title: Text("Place Details"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            child: Image.file(placeData.image,fit: BoxFit.cover,),
          ),
          Center(
            child: Text(placeData.title),
          ),
          SizedBox(height: 16,),

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

        ],
      ),
    );
  }
}
