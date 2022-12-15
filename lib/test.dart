import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTest extends StatefulWidget {
  const NewTest({Key? key}) : super(key: key);

  @override
  State<NewTest> createState() => _NewTestState();
}

class _NewTestState extends State<NewTest> {
  @override
  final ref = FirebaseFirestore.instance.collection('test');
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase CRUD"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: ref.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Text(
                            snapshot.data!.docs[index]['name'].toString());
                      });
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            // DashboardButton(),
          ],
        ),
      ),
    );
  }
}
