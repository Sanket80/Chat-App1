

import 'dart:convert';
import 'dart:io';

import 'package:chat_app/models/image_model.dart';
import 'package:http/http.dart' as http;

class ImageRepository{


  Future<List<PixelfordImage>> getNetworkImages() async {
    try {
    var endpointUrl = Uri.parse('https://pixelford.com/api2/images');

    final response = await http.get(endpointUrl);

    if (response.statusCode == 200) {
      final List<dynamic> decodedList = jsonDecode(response.body) as List;
      final List<PixelfordImage> _imageList = decodedList
          .map((listItem) => PixelfordImage.fromJson(listItem))
          .toList();
      print(_imageList[0].urlFullSize);
      return _imageList;
    } else {
      throw Exception('Failed to load images');
    }
  } on SocketException{
      throw Exception('No Internet Connection :(');
    } on HttpException{
      throw Exception("Couldn't retrieve the images! Sorry");
    } on FormatException{
      throw Exception("Bad response format!");
    } catch(e){
      print(e);
      throw Exception("Unknown error occurred!");
    }
  }
}