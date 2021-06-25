import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.logout),
        ),
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
          child: Text(
            'Welcome',
            style: TextStyle(color: Colors.redAccent, fontSize: 18),
          ),
        ));
  }
}
