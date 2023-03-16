import 'package:auth_app/screens/registor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../components/buttons.dart';
import '../components/connet.dart';
import '../components/textfield.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _uath = FirebaseAuth.instance;
    final emailController = TextEditingController();

    final passController = TextEditingController();

    // SignIn Method
    void signIn() async {
      showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      try {
        await _uath.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User not found Or Wrong Email"),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Wrong Password"),
            ),
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                Icon(
                  Icons.lock,
                  size: 100,
                ),
                SizedBox(height: 50),
                Text(
                  'Welcome back you have been missed!',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: "Username",
                  obscureText: false,
                ),
                SizedBox(height: 15),
                MyTextField(
                  controller: passController,
                  hintText: "Password",
                  obscureText: true,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        textAlign: TextAlign.end,
                        "Forget Password?",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                // Button
                ReusableButton(
                  onTap: () => signIn(),
                  text: "Sign In",
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Text(
                        "Or Continue with",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[700],
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePath: "images/google.png",
                    ),
                    SizedBox(width: 25),
                    SquareTile(
                      imagePath: "images/apple.png",
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
