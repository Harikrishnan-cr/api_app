import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/color_resources.dart';

Future<File?> pickImage(ImageSource source,
    {int imageQuality = 90, bool enableCrop = true}) async {
  final pickedFile = await ImagePicker().pickImage(
    source: source,
    imageQuality: imageQuality,
  );

  if (pickedFile != null && enableCrop) {
    return await cropImage(File(pickedFile.path));
  } else {
    return pickedFile == null ? null : File(pickedFile.path);
  }
}

Future<List<File>> pickMultiImage({
  int imageQuality = 90,
}) async {
  final pickedFile = await ImagePicker().pickMultiImage(
    imageQuality: imageQuality,
  );

  return pickedFile.map((e) => File(e.path)).toList();
}

Future<File?> cropImage(
  File image, {
  List<CropAspectRatioPreset> aspectRatioPresets = const [
    CropAspectRatioPreset.square,
  ],
  CropAspectRatio? cropAspectRatio,
  CropStyle cropStyle = CropStyle.rectangle,
}) async {
  final croppedImage = await ImageCropper().cropImage(
    sourcePath: image.path,
    aspectRatioPresets: aspectRatioPresets,
    aspectRatio: cropAspectRatio,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: ColorResources.primary,
        toolbarWidgetColor: ColorResources.WHITE,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      IOSUiSettings(
        title: 'Crop Image',
      )
    ],
    cropStyle: cropStyle,
  );

  return croppedImage == null ? null : File(croppedImage.path);
}

Future<File?> pickDoc({isDocOnly = true}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    dialogTitle: "Pick file to upload",
    type: FileType.custom,
    allowedExtensions: isDocOnly
        ? [
            'pdf',
          ]
        : ['mp4', 'pdf', 'jpg', 'png', 'jpeg', 'mov'],

    // allowedExtensions: ['*'],
  );

  if (result == null) {
    return null;
  }

  if (result.files.first.extension?.toLowerCase() == 'png' ||
      result.files.first.extension?.toLowerCase() == 'jpg' ||
      result.files.first.extension?.toLowerCase() == 'jpeg') {
    return await cropImage(File(result.files.first.path!));
  } else {
    return File(result.files.first.path!);
  }
}
