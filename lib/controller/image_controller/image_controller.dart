// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:g_route/constants/app_urls.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ImageController {
  static Future<String> uploadImage(
    List<File> images,
    String orderId,
    String imageType,
  ) async {
    print(images);

    var url =
        Uri.parse("${AppUrls.baseUrl}/api/v1/orders/addOrderImage/$orderId");

    print("url: $url");

    var request = http.MultipartRequest('POST', url);

    for (var image in images) {
      print('Adding image: ${image.path}');

      // Reusing the getMediaType function to determine the correct MIME type
      var multipartFile = http.MultipartFile.fromBytes(
        imageType == "Signature" ? 'signature' : 'image',
        await image.readAsBytes(),
        filename: image.path.split('/').last,
        contentType: getMediaType(image.path),
      );
      request.files.add(multipartFile);
    }

    print(request.files);

    var response = await request.send();
    print('Response status code: ${response.statusCode}');

    // Convert the streamed response into a regular response to access the body
    var responseBody = await http.Response.fromStream(response);

    // Print the response body
    print('Response body: ${responseBody.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return 'Image uploaded successfully';
    } else {
      return 'Failed to upload image';
    }
  }

  // Helper function to get MIME type from file extension
  static MediaType getMediaType(String path) {
    final mimeType = lookupMimeType(path);
    if (mimeType != null) {
      final parts = mimeType.split('/');
      if (parts.length == 2) {
        return MediaType(parts[0], parts[1]);
      }
    }
    return MediaType('application', 'octet-stream');
  }
}
