import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class InputFields extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<String> labels;
  final List<String> userInfo;
  final Function(String?) imageData;

  const InputFields(this.controllers, this.labels, this.userInfo, this.imageData);

  @override
  _InputFieldsState createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  String? imageData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < widget.labels.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: widget.controllers[i],
              obscureText: widget.labels[i].toLowerCase().contains('password'),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: widget.userInfo[i],
                hintText: widget.labels[i],
              ),
            ),
          ),
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);

              if (image != null) {
                final bytes = await image.readAsBytes();
                setState(() {
                  imageData = base64Encode(bytes);
                  widget.imageData(imageData); 
                });
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              foregroundColor: Colors.red,
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(
              Icons.cloud, 
              size: 24,
            ),
            label: const Text(
              'Upload image',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}