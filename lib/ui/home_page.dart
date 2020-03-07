import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Etanol X Gasolina"),
        centerTitle: false,
        backgroundColor: Color(0xFF89aec9),
      ),
      body: Text("Relou Uordi", style: TextStyle(color: Colors.black, fontSize: 44)),
      backgroundColor: Colors.white
    );
  }
}
