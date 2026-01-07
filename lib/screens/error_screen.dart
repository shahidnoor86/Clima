import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.lightBlue),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Location access is required",
              style: TextStyle(fontSize: 22.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
