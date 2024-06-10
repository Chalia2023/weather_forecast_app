import 'package:flutter/material.dart';

class ErrorHandling extends StatelessWidget {
  final String errorMessage;

  const ErrorHandling({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: const TextStyle(color: Colors.red),
    );
  }
}
