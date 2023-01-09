import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe_web_payment/subscription.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  var _productId = '';

  var _checkoutSessionId = '';

  void _onSelectProduct(String? id) {
    setState(() => _productId = id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        'You can buy any of our memberships as a gift for you or someone else',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // displaying products which is active
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .where('active', isEqualTo: true)
                          .snapshots(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('$snapshot.error'));
                        } else if (!snapshot.hasData) {
                          return const Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        var docs = snapshot.data!.docs;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            print("product id");
                            print(_productId.toString());
                            final doc = docs[index];
                            return RadioListTile(
                              groupValue: _productId,
                              value: doc.id,
                              onChanged: _onSelectProduct,
                              title: Text('${doc['name']}'),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      // mainAxisSize: MainAxisSize.c,
                      children: <Widget>[
                        if (_checkoutSessionId.isEmpty) //

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20)),
                              onPressed: () async {
                                final price = await FirebaseFirestore.instance
                                    .collection('products')
                                    .doc(_productId)
                                    .collection('prices')
                                    .where('active', isEqualTo: true)
                                    .limit(1)
                                    .get();
                                final docRef = await FirebaseFirestore.instance
                                    .collection('customers')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .collection("checkout_sessions")
                                    .add({
                                  "client": "web",
                                  "mode": "subscription",
                                  "price": price.docs[0].id,
                                  "success_url":
                                      'http://localhost:5600/success',
                                  "cancel_url": 'http://localhost:5600/cancel'
                                });
                                setState(() => _checkoutSessionId = docRef.id);
                              },
                              child: const Text('Subscribe'),
                            ),
                          )
                        else
                          Subscription(
                            checkoutSessionId: _checkoutSessionId,
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.orangeAccent,
                  height: MediaQuery.of(context).size.height,
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/5230/5230935.png',
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
