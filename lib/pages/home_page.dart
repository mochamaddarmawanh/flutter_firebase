// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/get_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  List<String> docIDs = [];

  Future getDocIDs() async {
    await FirebaseFirestore.instance.collection('users').orderBy('age', descending: true).get().then((snapshot) => snapshot.docs.forEach((document) {
      docIDs.add(document.reference.id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Flutter Firebase',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  showDialog(context: context, builder: (builder) {
                    return Center(child: CircularProgressIndicator());
                  });
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.logout),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            Text(
              'You\'re signed in as: ',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              // '${user?.email}',
              user?.email ?? 'No email available',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(context: context, builder: (builder) {
                  return Center(child: CircularProgressIndicator());
                });
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(10),
                // ),
              ),
              child: Text(
                'SIGN OUT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: getDocIDs(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: GetUser(documentId: docIDs[index]),
                          tileColor: Colors.black,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
