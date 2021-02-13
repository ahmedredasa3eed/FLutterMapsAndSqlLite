import 'package:flutter/material.dart';
import 'package:nativefeatures/providers/place_provider.dart';
import 'package:nativefeatures/screens/add_place_screen.dart';
import 'package:nativefeatures/screens/place_details_screen.dart';
import 'package:provider/provider.dart';

class PlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, NewPlaceScreen.route);
              }),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context,listen: false).getPlacesData(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<PlaceProvider>(
                    builder: (context, place, child) {
                      return place.items.length <= 0
                          ? Center(
                              child: Text("No Places Found"),
                            )
                          : ListView.builder(
                              itemCount: place.items.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(place.items[index].title),
                                  subtitle: Text(place.items[index].location.address),
                                  leading: Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.file(place.items[index].image),
                                  ),
                                  onTap: (){
                                    Navigator.pushNamed(context, PlaceDetails.route, arguments: place.items[index]);
                                  },
                                );
                              });
                    },
                  ),
      ),
    );
  }
}
