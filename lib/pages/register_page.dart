// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../my_dialog.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Textfield controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // On tap sign in
  Future signUp() async {
    if (_firstNameController.text.trim().isEmpty || _lastNameController.text.trim().isEmpty || _ageController.text.trim().isEmpty) {
      my_dialog(context: context, error: true, message: 'First name, last name and age are required!');
      return;
    }

    if (passwordConfirmed()) {
      try {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        addUserDetails(
          _emailController.text.trim(),
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          int.parse(_ageController.text.trim()),
        );

        my_dialog(context: context, error: false, message: 'User added to system successfully!');

      } on FirebaseAuthException catch (e) {
        print('Failed to sign up: ${e.message}');
        my_dialog(context: context, error: true, message: e.message.toString());
      }
    } else {
      print('Passwords do not match');
      my_dialog(context: context, error: true, message: 'Passwords do not match!');
    }
  }

  Future addUserDetails(String email, String firstName, String lastName, int age) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
      });
      print('User details added to Firestore.');
    } catch (e) {
      print('Failed to add user details: $e');
      my_dialog(context: context, error: true, message: e.toString());
    }
  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() == _confirmPasswordController.text.trim();
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
                // Greeting
                Text(
                  'Register now, mate 🤙',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Register below with your details!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 50),

                // First Name Textfield
                _buildTextField(_firstNameController, 'First Name', autofocus: true),

                SizedBox(height: 10),

                // Last Name Textfield
                _buildTextField(_lastNameController, 'Last Name'),

                SizedBox(height: 10),

                // Age Textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Age',
                          hintStyle: TextStyle(color: Colors.white60),
                        ),
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Email Textfield
                _buildTextField(_emailController, 'Email'),

                SizedBox(height: 10),

                // Password textfield
                _buildTextField(_passwordController, 'Password', obscureText: true),

                SizedBox(height: 10),

                // Confirm password textfield
                _buildTextField(_confirmPasswordController, 'Confirm Password', obscureText: true),

                SizedBox(height: 15),

                // Sign-up button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: signUp,
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
                              'SIGN-UP',
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

                // Already a member? Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Text(
                          ' login here',
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

  Widget _buildTextField(TextEditingController controller, String hintText, {bool autofocus = false, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            autofocus: autofocus,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.white60),
            ),
            controller: controller,
            obscureText: obscureText,
          ),
        ),
      ),
    );
  }
}
