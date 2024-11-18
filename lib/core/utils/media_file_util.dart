import 'dart:convert';
import 'dart:developer';
import 'package:aider_mobile_app/core/constants/colors.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class MediaFileUtil {
  static Future<String?> cropImage(
    String path, {
    String title = 'Crop Photo',
    bool hideBottomControls = true,
  }) async {
    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: title,
          toolbarColor: kPrimaryBlack,
          toolbarWidgetColor: kPrimaryWhite,
          hideBottomControls: hideBottomControls,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: title,
          aspectRatioLockEnabled: false,
          hidesNavigationBar: hideBottomControls,
        ),
      ],
    ).onError((error, stackTrace) {
      log(error.toString());
      return null;
    });

    return cropped?.path;
  }

  static Future<XFile?> pickImageFrom(
    ImageSource imageSource, {
    int imageQuality = 50,
    bool cameraFront = false,
  }) async {
    try {
      final XFile? file = await ImagePicker().pickImage(source: imageSource, imageQuality: imageQuality, preferredCameraDevice: CameraDevice.front);
      return file;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<dynamic> pickImage({bool allowMultiple = false, String title = 'Select a Photo'}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: title,
        type: FileType.image,
        withReadStream: true,
        allowMultiple: allowMultiple,
      );
      return result;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // static Future<XFile?> compressAndGetFile(String imagePath, {int quality = 50, int maxSizeInBytes = 1024 * 1024}) async {
  //   try {
  //     final lastIndex = imagePath.lastIndexOf(RegExp(r'.jp'));
  //     final split = imagePath.substring(0, (lastIndex));
  //     final targetPath = "${split}_out${imagePath.substring(lastIndex)}";
  //     int step = 10;
  //     int currentQuality = quality;
  //
  //     var result = await FlutterImageCompress.compressAndGetFile(
  //       imagePath,
  //       targetPath,
  //       minHeight: 620,
  //       minWidth: 376,
  //       quality: currentQuality,
  //     );
  //
  //     if (result != null) {
  //       final fileSize = await result.length();
  //       if (fileSize <= maxSizeInBytes) {
  //         return result;
  //       }
  //     }
  //
  //     currentQuality -= step;
  //
  //     return result;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  static Future<XFile?> compressAndGetFile(String imagePath, {int quality = 75}) async {
    try{
      final lastIndex = imagePath.lastIndexOf(RegExp(r'.jp'));
      final split = imagePath.substring(0, (lastIndex));
      final targetPath = "${split}_out${imagePath.substring(lastIndex)}";

      var result = await FlutterImageCompress.compressAndGetFile(
        imagePath,
        targetPath,
        minHeight: 820,
        minWidth: 576,
        quality: quality,
      );

      return result;
    }catch(e){
      return null;
    }
  }

  static Future<String> convertFileToBase64(String filePath) async {
    try {
      XFile imageFile = XFile(filePath);
      final bytes = await imageFile.readAsBytes();
      log(base64Encode(bytes));
      return base64Encode(bytes);
    } catch (e) {
      return '';
    }
  }

  static Future<String?> getPickedSourceImage({bool camera = true, bool cropped = true, bool cameraFront = false}) async {
    try {
      final selectedFile = await pickImageFrom(camera ? ImageSource.camera : ImageSource.gallery, cameraFront: cameraFront);
      log(selectedFile?.length().toString() ?? "");
      if (selectedFile != null) {
        if (cropped) return cropSelectedImage(selectedFile);

        return selectedFile.path;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<String?> getPickedImage({bool allowMultiple = false, bool cropped = true}) async {
    try {
      var result = await pickImage(allowMultiple: allowMultiple);
      if (result != null) {
        if (cropped) return cropSelectedImage(XFile(result.files.single.path!));

        return result.files.single.path;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<dynamic> getMultiplePickedImage() async {
    try {
      final result = await pickImage(allowMultiple: true);
      if (result != null) {
        return result.files;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  static Future<String?> cropSelectedImage(XFile source) async {
    String? cropped = await cropImage(source.path, hideBottomControls: false);
    return cropped;
  }

  static Future<MultipartFile?>? getMultipartFile(String filePath) async {
    try {
      return filePath.isEmpty ? null : await MultipartFile.fromFile(filePath, filename: p.basename(filePath));
    } catch (e) {
      return null;
    }
  }
}
