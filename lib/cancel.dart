import 'package:flutter/material.dart';

class CancelPage extends StatelessWidget {
  const CancelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel Page"),
      ),
      body: Center(
        child: Text(
          'Your Payment has been unsuccessful',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}