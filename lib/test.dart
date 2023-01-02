import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTest extends StatefulWidget {
  const NewTest({Key? key}) : super(key: key);

  @override
  State<NewTest> createState() => _NewTestState();
}

class _NewTestState extends State<NewTest> {
  @override
  FirebaseAuth auth = FirebaseAuth.instance;
  final ref = FirebaseFirestore.instance.collection('products');

  Widget build(BuildContext context) {
    final Priceref = FirebaseFirestore.instance.collection('prices');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase CRUD"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: ref.where("active", isEqualTo: true).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs.length;
                        return Column(
                          children: [
                            Text(snapshot.data!.docs[index]['description']
                                .toString()),
                            TextButton(
                              onPressed: () {},
                              child: Text('donate'),
                            ),
                          ],
                        );
                      });
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            Container(
              height: 300,
              width: 400,
              color: Colors.blue,
              child: StreamBuilder(
                stream: Priceref.where('uid', isEqualTo: auth.currentUser?.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                  if (snapshots.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          print("============price===========");
                          print(snapshots.data!.docs[index].toString());
                          return Column(
                            children: [
                              Text(snapshots.data!.docs[0].id.toString()),
                              TextButton(
                                onPressed: () => {},
                                child: Text('donate'),
                              ),
                            ],
                          );
                        });
                  } else {
                    print(snapshots.error.toString());
                    return Text(snapshots.error.toString());
                  }
                },
              ),
            )
            // DashboardButton(),
          ],
        ),
      ),
    );
  }
}
