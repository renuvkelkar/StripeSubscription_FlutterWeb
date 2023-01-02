import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_stripe_web_payment/dashboard.dart';
import 'package:flutter_stripe_web_payment/test.dart';
import 'package:flutter_stripe_web_payment/utils/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  TextEditingController _nameTextController = TextEditingController();

  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _passwordTextController = TextEditingController();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Form(
              key: _formKey,
              child: Center(
                child: Container(
                  color: Colors.teal,
                  height: 500,
                  width: 500,
                  child: Column(
                    children: <Widget>[
                      // TextFormField(
                      //     controller: _nameTextController,
                      //     decoration: InputDecoration(label: Text("Name"))),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffb21a583),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffb21a583),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      // TextFormField(
                      //     controller: _emailTextController,
                      //     decoration: InputDecoration(label: Text("Email"))),

                      SizedBox(height: 8.0),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _passwordTextController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffb21a583),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffb21a583),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                      // TextFormField(
                      //     controller: _passwordTextController,
                      //     decoration: InputDecoration(label: Text("Password"))),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () async {
                          User? user = await FireAuth.signInUsingEmailPassword(
                            email: _emailTextController.text,
                          );
                          if (user != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => DashboardPage()),
                            );
                          }
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}
