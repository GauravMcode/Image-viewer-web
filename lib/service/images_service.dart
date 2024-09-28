import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:images_viewer/model/image_data.dart';
import 'package:logger/web.dart';

class ImagesService {
  var logger = Logger();
  Future<List<ImageData>> fetchImages(
      {required int page, required int pageSize}) async {
    List<ImageData> images = [];
    try {
      logger.i(page);
      final response = await http.get(Uri.parse(
          "https://pixabay.com/api/?key=${dotenv.env['PIXABAY_KEY']}&image_type=photo&page=$page&per_page=$pageSize"));

      final data = jsonDecode(response.body);

      for (var element in data['hits']) {
        images.add(ImageData.fromJson(element));
      }
    } catch (e) {
      logger.e(e);
    }
    return images;
  }
}
