import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nativefeatures/helpers/db_helper.dart';
import 'package:nativefeatures/helpers/location_helper.dart';
import 'package:nativefeatures/models/place.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String pickedTitle, File pickedImage, PlaceLocation pickedLocation) async {

    final address = await LocationHelper.getPlaceAddress(pickedLocation.latitude, pickedLocation.longitude);

    final updatedPlaceLocation = PlaceLocation(latitude: pickedLocation.latitude, longitude: pickedLocation.longitude, address: address);

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: updatedPlaceLocation,
      image: pickedImage,
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat' : newPlace.location.latitude,
      'loc_lon' : newPlace.location.longitude,
      'loc_address' : newPlace.location.address,
    });
  }

  Future<void> getPlacesData() async {
    final data = await DBHelper.getData('user_places');
    _items = data.map((item) =>
        Place(id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(latitude: item['loc_lat'], longitude: item['loc_lon'], address: item['loc_address']),
        )).toList();
    notifyListeners();
  }
}
