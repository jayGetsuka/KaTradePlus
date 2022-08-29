import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: SizedBox(
            width: double.infinity,
            height: 500,
            child: Column(
              children: [
                Center(
                  child: Text("KATRADE PLUS+", style: TextStyle(fontSize: 25)),
                )
              ],
            )),
      ),
    );
  }
}
