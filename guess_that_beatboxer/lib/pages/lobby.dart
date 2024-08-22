import 'package:flutter/material.dart';
import 'package:guess_that_beatboxer/widgets/appBar.dart';  
import 'package:guess_that_beatboxer/Widgets/appBar.dart';

class Lobby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarFunction("Lobby"),
      body: Text("test"),
    );
  }
  
}