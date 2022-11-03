import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  final String title;
  final String error;
  const ErrorWidget({super.key, required this.title, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: Text(
        error,
        style: const TextStyle(fontSize: 24.0),
      )),
    );
  }
}
