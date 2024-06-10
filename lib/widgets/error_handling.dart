import 'package:flutter/material.dart';

class ErrorHandling extends StatelessWidget {
  final String errorMessage;

  const ErrorHandling({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: TextStyle(color: Colors.red),
    );
  }
}
