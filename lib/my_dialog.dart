// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void my_dialog({required BuildContext context, required bool error, required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          error ? 'Error' : 'Success',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: error ? Colors.redAccent : Colors.greenAccent,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.black,
      );
    },
  );
}