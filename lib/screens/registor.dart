import 'package:auth_app/components/buttons.dart';
import 'package:auth_app/screens/home_page.dart';
import 'package:auth_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/connet.dart';
import '../components/textfield.dart';

class Registration extends StatefulWidget {
  final Function()? onTap;
  const Registration({Key? key, this.onTap}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPassController = TextEditingController();

    void showError(String text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
    }

    //  Sign Up Method
    void signUp() async {
      showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      try {
        if (passwordController.text == confirmPassController.text) {
          await _auth.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: confirmPassController.text.trim(),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Password are not same"),
            ),
          );
        }
        //Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showError(e.code);
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Icon(
                Icons.lock,
                size: 80,
              ),
              SizedBox(height: 50),
              Text(
                "let's create an account for you!",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 25),
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              SizedBox(height: 15),
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              SizedBox(height: 15),
              MyTextField(
                controller: confirmPassController,
                hintText: "Confirm Password",
                obscureText: true,
              ),
              SizedBox(height: 25),
              ReusableButton(
                text: "Sign Up",
                onTap: signUp,
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
                    "I'am a member?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'login now',
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
    );
  }
}
