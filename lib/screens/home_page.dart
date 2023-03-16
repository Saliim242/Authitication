import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Get Current User Email
    final user = FirebaseAuth.instance.currentUser!;
    // Sign Out Method
    void signout() async {
      await FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signout,
            icon: Icon(
              Icons.logout_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          textAlign: TextAlign.center,
          "Well Done You Signed In : " + user.email!,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
