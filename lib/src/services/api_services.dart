import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/image_data_model.dart';

class ApiServices {
  const ApiServices();

  static const String _imageUrl = "https://api.nasa.gov/planetary/apod";
  static const String _apiKey = "18QBwoiRpbFgeYBSl3PxFHi2aoJjrt7lIindJfng";

  static Future<ImageDataModel> getImageData(String? date) async {
    try {

      var fullUrl = "$_imageUrl?api_key=$_apiKey";
      if (date != null && date.isNotEmpty) {
        fullUrl = "$fullUrl&date=$date";
      }
      final url = Uri.parse(fullUrl);
      log(fullUrl);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return ImageDataModel.fromJson(jsonDecode(response.body));
      }
      throw Exception("Http Exception");
    } catch (e) {
      rethrow;
    }
  }
}