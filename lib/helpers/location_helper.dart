import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_MAP_API_KEY = "AIzaSyAfzjGOqWeBsoPT05BwJS6ysXB-8FQcRAA";

class LocationHelper{

  static String generateMapPreviewImageUrl(double latitude , double longitude){

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=18&size=600x300&maptype=roadmap&markers=color:green%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_MAP_API_KEY';
  }

  static Future<String> getPlaceAddress(double latitude , double longitude) async {

    final url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_MAP_API_KEY";

    final response = await http.get(url);

    if(response.statusCode == 200){

      return json.decode(response.body)['results'][0]['formatted_address'];
    }

  }

}