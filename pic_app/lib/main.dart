import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan[400],
        appBar: AppBar(
          title:Text('Network Image APP'),
          backgroundColor: Colors.cyan,
          ),
      body: Center(
        child: Image(
          image:
                NetworkImage('http://icons.iconarchive.com/icons/graphicloads/100-flat/256/home-icon.png'),
        ),
      ),
      ),
    ),
  );
}