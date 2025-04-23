import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import '../../core/constants/app_constants.dart';

class ImageUploadResponse {
  final String message;
  final String filename;
  final String path;

  ImageUploadResponse({
    required this.message,
    required this.filename,
    required this.path,
  });

  factory ImageUploadResponse.fromJson(Map<String, dynamic> json) {
    return ImageUploadResponse(
      message: json['message'],
      filename: json['filename'],
      path: json['path'],
    );
  }
}

class ImageUploadService {
  final Dio _dio = Dio();
  final String _baseUrl = '${AppApi.baseUrl}/upload';
  Future<ImageUploadResponse> uploadImage(File image) async {
    final allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
    final extension = '.${image.path.split('.').last.toLowerCase()}';

    FormData formData;

    if (allowedExtensions.contains(extension)) {
      // Upload original file
      formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });
    } else {
      // Read and decode the original image
      final bytes = await image.readAsBytes();
      final decodedImage = img.decodeImage(bytes);

      if (decodedImage == null) {
        throw Exception('Could not decode image');
      }

      // Convert to PNG
      final pngBytes = img.encodePng(decodedImage);

      // Upload converted PNG bytes
      formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          pngBytes,
          filename: '${DateTime.now().millisecondsSinceEpoch}.png',
          contentType: MediaType('image', 'png'),
        ),
      });
    }

    // Send the request
    final response = await _dio.post('$_baseUrl/image', data: formData);

    // Return the parsed response
    return ImageUploadResponse.fromJson(response.data);
  }
}
