import 'package:flutter/material.dart';


appBarLobbyFunction (text, {Widget? action}) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/logo.png',
          fit: BoxFit.contain,
          height: 42, 
        ),
        const SizedBox(width: 25),
        Text(text),
      ],
    ),
    centerTitle: true,
    actions: action != null ? [action] : [],
  );
}