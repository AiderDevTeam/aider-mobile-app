import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:aider_mobile_app/core/services/remote_config_service.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class CloudinaryService {
  CloudinaryService._();
  static final instance = CloudinaryService._();

  final CloudinaryPublic cloudinary = CloudinaryPublic(
    RemoteConfigService.getRemoteData.configs['env']['cloudinaryCloudName'],
    RemoteConfigService.getRemoteData.configs['env']['cloudinaryUploadPreset'],
    cache: false,
  );

  Future<String?> uploadImage(
    String imagePath,
    void Function(int, int)? onProgress,
  ) async {
    try {
      ZLoggerService.logOnInfo('UPLOAD IMAGE PATH: $imagePath');

      // Validate file exists and is readable
      final file = File(imagePath);
      if (!await file.exists()) {
        ZLoggerService.logOnError('File does not exist at path: $imagePath');
        return null;
      }

      final uploadResult = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imagePath,
          resourceType:
              CloudinaryResourceType.Image, // Explicitly specify resource type
        ),
        onProgress: onProgress,
      );

      ZLoggerService.logOnInfo(
          'UPLOAD IMAGE RESULT: ${uploadResult.secureUrl}');
      return uploadResult.secureUrl;
    } catch (e) {
      // More detailed error logging
      if (e is DioException) {
        ZLoggerService.logOnError(
            'UPLOAD IMAGE ERROR: Status ${e.response?.statusCode}, '
            'Message: ${e.response?.data}, '
            'Headers: ${e.response?.headers}');
      } else {
        ZLoggerService.logOnError('UPLOAD IMAGE ERROR: $e');
      }
      return null;
    }
  }
}
