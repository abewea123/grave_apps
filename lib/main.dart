import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('E-Grave Lot'),
          backgroundColor: Colors.redAccent,
        ),
        body:const Center(
          child: Image(
            image:
              AssetImage('images/logo.jpg'),
          ),
        ),
      ),
    ),
  );
}