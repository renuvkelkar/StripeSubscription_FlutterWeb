import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe_web_payment/subscription.dart';

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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Stripe Payments Extension Example',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 32),
              Text(
                'The latest messages',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
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
                      itemCount: docs.length,
                      itemBuilder: (BuildContext context, int index) {
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
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 30),
                    if (_checkoutSessionId.isEmpty) //
                      ElevatedButton(
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
                            "success_url": 'http://localhost:5600/#/success',
                            "cancel_url": 'http://localhost:5600/#/cancel'
                          });
                          setState(() => _checkoutSessionId = docRef.id);
                        },
                        child: const Text('Subscribe'),
                      )
                    else
                      Subscription(
                        checkoutSessionId: _checkoutSessionId,
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
