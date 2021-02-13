import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nativefeatures/models/place.dart';
import 'package:nativefeatures/providers/place_provider.dart';
import 'package:nativefeatures/widgets/image_input.dart';
import 'package:nativefeatures/widgets/location_input.dart';
import 'package:provider/provider.dart';

class NewPlaceScreen extends StatefulWidget {
  static const route = 'add-new-place';

  @override
  _NewPlaceScreenState createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends State<NewPlaceScreen> {

  TextEditingController _titleController = TextEditingController();

  File _selectedImageFile;

  PlaceLocation _pickedLocation ;

  void _onSelectedImage(File pickedImage){
    _selectedImageFile = pickedImage;
  }

  void _onSelectPlace(double latitude , double longitude){
    _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude);
  }

  void _savePlace(){
    if(_selectedImageFile == null || _titleController.text.isEmpty || _pickedLocation == null){
       return;
    }
    Provider.of<PlaceProvider>(context,listen: false).addPlace(_titleController.text, _selectedImageFile, _pickedLocation);
    Navigator.of(context).pop();


  }
  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: "Place Title"
                      ),
                    ),

                    SizedBox(height: 16,),
                    ImageInput(_onSelectedImage),
                    SizedBox(height: 16,),
                    LocationInput(_onSelectPlace),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 80,
            child: RaisedButton.icon(
              onPressed: _savePlace,
              icon: Icon(Icons.add),
              label: Text(" Save Place"),
              color: Colors.lightGreen,
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
