// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../my_dialog.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // Textfield controller
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // On tap sign in
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      my_dialog(context: context, error: false, message: 'Password reset link sent! Check your email.');
    } on FirebaseAuthException catch (e) {
      my_dialog(context: context, error: true, message: e.message.toString());
    }
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
          'Forgetten Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Enter your email and we will send you a password reset link',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 10),

                // Email Textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.5),
                          //     spreadRadius: 2,
                          //     blurRadius: 7,
                          //     offset: Offset(0, 3),
                          //   ),
                          // ],
                        ),
                        child: TextField(
                          autofocus: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white60),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical:
                                    15), // Adjust padding inside the TextField
                          ),
                          controller: _emailController,
                        ),
                      )),
                ),

                SizedBox(height: 15),

                ElevatedButton(
                  onPressed: passwordReset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                  ),
                  child: Text(
                    'RESET PASSWORD',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
