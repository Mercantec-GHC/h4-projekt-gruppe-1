import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_field/image_field.dart';
import 'package:image_picker/image_picker.dart';

typedef Progress = Function(double percent);

class UploadRemoteImageForm extends StatefulWidget {
  const UploadRemoteImageForm({super.key, required this.title, required this.onImageUploaded});

  final String title;
  final Function(String?) onImageUploaded;

  @override
  State<UploadRemoteImageForm> createState() => _UploadRemoteImageFormState();
}

class _UploadRemoteImageFormState extends State<UploadRemoteImageForm> {
  dynamic remoteFiles;

  Future<String?> uploadToServer(XFile? file, {Progress? uploadProgress}) async {
    if (file == null) {
      return null;
    }

    List<int> bytes = await file.readAsBytes();
    String base64Image = base64Encode(bytes);
    return base64Image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: ImageField(
        multipleUpload: false,

        texts: const {
          'fieldFormText': 'Upload to server',
          'titleText': 'Upload to server'
        },
        remoteImage: true,
        onUpload: (pickedFile, controllerLinearProgressIndicator) async {
          dynamic fileUploaded = await uploadToServer(pickedFile);

          return fileUploaded;
        },
        onSave: (List<ImageAndCaptionModel>? imageAndCaptionList) {
          remoteFiles = imageAndCaptionList;
        },
      ),
    );
  }
}