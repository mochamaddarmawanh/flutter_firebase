// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUser extends StatelessWidget {
  final String documentId;

  const GetUser({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder(future: users.doc(documentId).get(), builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        return Text(
          data['firstName'] + ' ' + data['lastName'] + ', ' + data['age'].toString() + ' years old',
          style: TextStyle(
            color: Colors.white
          ),
        );
      }
      return Text('Loading');
    }));
  }
}