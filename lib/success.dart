import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef _CheckoutSessionSnapshot = DocumentSnapshot<Map<String, dynamic>>;

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Success page"),
      ),
      body: Center(
        child: Text(
          'Your payment has been successful',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
