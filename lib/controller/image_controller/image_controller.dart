import 'dart:convert';
import 'dart:io';
import 'package:g_route/constants/app_urls.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';

class ImageController {
  static final _logger = Logger();

  /// Uploads images to the server. If an image exceeds 5 MB, it is resized before uploading.
  static Future<String> uploadImage(
    List<File> images,
    String orderId,
    String imageType, {
    int maxSizeInBytes = 5000000, // 5 MB
  }) async {
    var url = Uri.parse(
        "${AppUrls.baseUrl}/api/v1/assignedOrder/addAssignedOrderImage/$orderId");

    _logger.i("Uploading images to: $url");

    var request = http.MultipartRequest('POST', url);

    try {
      for (var image in images) {
        // Resize the image if it exceeds the maximum size
        File resizedImage =
            await resizeImageIfNeeded(image, maxSizeInBytes: maxSizeInBytes);

        _logger.d('Adding image: ${resizedImage.path}');

        var mimeType = getMediaType(resizedImage.path);

        var multipartFile = await http.MultipartFile.fromPath(
          imageType == "Signature" ? 'signature' : 'image',
          resizedImage.path,
          contentType: mimeType,
        );

        request.files.add(multipartFile);
      }

      var response = await request.send();
      _logger.i('Response status code: ${response.statusCode}');

      var responseBody = await http.Response.fromStream(response);

      _logger.d('Response body: ${responseBody.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Image uploaded successfully';
      } else {
        var msg = jsonDecode(responseBody.body);
        throw Exception(msg['error'] ?? 'Failed to upload image');
      }
    } catch (e) {
      _logger.e("An error occurred while uploading the images: $e");
      throw Exception("Image upload failed. Please try again.");
    }
  }

  /// Resizes the image to a smaller size and compresses it if it exceeds the specified maximum size in bytes.
  static Future<File> resizeImageIfNeeded(File image,
      {int maxSizeInBytes = 5000000}) async {
    // Check if the image file size is larger than the specified max size
    if (await image.length() > maxSizeInBytes) {
      final imageBytes = await image.readAsBytes();

      // Decode the image to determine its current size
      img.Image? originalImage = img.decodeImage(imageBytes);
      if (originalImage == null) {
        throw Exception("Unable to decode image");
      }

      // More aggressive resizing strategy: reduce image size by 50% or more
      double scaleFactor = (maxSizeInBytes / imageBytes.length)
          .clamp(0.0, 0.5); // Cut size to 50% or smaller

      // Calculate the new dimensions while maintaining the aspect ratio
      int newWidth = (originalImage.width * scaleFactor).round();
      int newHeight = (originalImage.height * scaleFactor).round();

      // Resize the image
      img.Image resizedImage =
          img.copyResize(originalImage, width: newWidth, height: newHeight);

      // Apply higher compression (lower quality)
      List<int> resizedImageBytes =
          img.encodeJpg(resizedImage, quality: 50); // Lower quality to 50%

      // Save the resized image back to a file (overwriting the original)
      File resizedImageFile = await image.writeAsBytes(resizedImageBytes);

      _logger.i("Image resized to: ${resizedImageFile.lengthSync()} bytes");

      return resizedImageFile;
    } else {
      return image; // Return the original image if resizing is not needed
    }
  }

  /// Helper function to get MIME type from file extension
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
