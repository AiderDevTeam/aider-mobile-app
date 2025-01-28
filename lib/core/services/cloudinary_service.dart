import 'package:aider_mobile_app/core/services/remote_config_service.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryService {
  CloudinaryService._();
  static final instance = CloudinaryService._();

  final CloudinaryPublic cloudinary = CloudinaryPublic(
    RemoteConfigService.getRemoteData.cloudinaryCloudName,
    RemoteConfigService.getRemoteData.cloudinaryUploadPreset,
    cache: false,
  );

  Future<String> uploadImage(
    String imagePath,
    void Function(int, int)? onProgress,
  ) async {
    final uploadResult = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(imagePath),
      onProgress: onProgress,
    );

    return uploadResult.secureUrl;
  }
}
