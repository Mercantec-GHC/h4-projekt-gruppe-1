import 'package:flutter/material.dart';

class DefaultImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0, 
      height: 80.0, 
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        color: Colors.red,
        size: 40.0,
      ),
    );
  }
}
