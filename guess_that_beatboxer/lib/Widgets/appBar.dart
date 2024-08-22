import 'package:flutter/material.dart';


appBarFunction (text){
  return(AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('../assets/logo.png',
              fit: BoxFit.contain,
              height: 42, 
            ),
            SizedBox(width: 25),
            Text(text),
          ],
        ),
        centerTitle: true,
      ));
 }
