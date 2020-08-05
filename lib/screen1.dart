import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  String payload;

  Screen1(this.payload);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 1"),
      ),
      body: Center(
        child: Text(payload),
      ),
    );
  }
}
