// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_password.dart';
import '../my_dialog.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Textfield controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // On tap sign in
  Future signIn() async {
    showDialog(
      context: context,
      // barrierDismissible: false, // Prevents the user from closing the dialog by tapping outside
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.of(context).pop();

    } on FirebaseAuthException catch (e) {

      Navigator.of(context).pop();

      my_dialog(
        context: context,
        error: true,
        message: e.message.toString(),
      );
    } catch (e) {

      Navigator.of(context).pop();

      my_dialog(
        context: context,
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // icon
                Icon(
                  Icons.account_box,
                  size: 75,
                  color: Colors.white,
                ),

                SizedBox(height: 75),

                // Greating
                Text(
                  'Hello, mate 👋',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 50),

                // Email Textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          // border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white60),
                        ),
                        controller: _emailController,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          // border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white60),
                        ),
                        controller: _passwordController,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Not a member? register now
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgotten password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPasswordPage();
                              },
                            ),
                          );
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            ' reset here',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                // Sign in button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signIn,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'SIGN-IN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                // Not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          ' register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
