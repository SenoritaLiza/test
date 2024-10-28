import 'package:flutter/material.dart';
import 'AppBar+NavBar.dart'; 


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomBottomNavigationBar(), // Указываем основной виджет
    );
  }
}