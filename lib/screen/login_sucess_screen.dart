// ignore_for_file: use_build_context_synchronously

import 'package:firebase_login/screen/LoginSceen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firebaseInst = FirebaseAuth.instance;

class LoginSucess extends StatefulWidget {
  const LoginSucess({super.key});

  @override
  State<LoginSucess> createState() => _LoginSucessState();
}

//After Successful Login , this screen opens up.
class _LoginSucessState extends State<LoginSucess> {
  @override
  Widget build(BuildContext context) {
    Future<void> logout() async {
      await firebaseInst.signOut();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Logged out')));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Authenticated'),
          actions: [
            IconButton(
                onPressed: logout, icon: const Icon(Icons.logout_rounded))
          ],
        ),
        body: const Center(
          child: Text(
            "Authenticated Succesfully",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
