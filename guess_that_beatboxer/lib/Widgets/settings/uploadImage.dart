/* import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:guess_that_beatboxer/api/user_register.dart';

class ImageUploadWidget extends StatefulWidget {
  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        String? base64Image = _convertToBase64(_image);
        if (base64Image != null) {
        print(base64Image);
        }
      } else {
        print('No image selected.');
      }
    });
  }

  String? _convertToBase64(File? image) {
    if (image == null) return null;
    final bytes = image.readAsBytesSync();
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Pick Image'),
        ),
        if(_image != null)
          Image.file(_image!),
          Text("sdfsfsdf")

      ],
    );
  }
} */