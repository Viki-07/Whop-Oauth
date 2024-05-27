import 'package:firebase_login/screen/login_sucess_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//instantiating a firebase instance for authentication.
final firebaseInst = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //defining important variables
  final formkey = GlobalKey<FormState>();
  bool isLogin = true;
  var emailid = '';
  var pass = '';
  var uname = '';
  var isAuthenticating = false;

  //this functions provides functionality of Sign In and Sign Up.
  void onSubmit() async {
    // bool isValid = true;
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      return;
    }

    formkey.currentState!.save();
    if (isLogin) {
      try {
        setState(() {
          isAuthenticating = true;
        });
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return const LoginSucess();
          },
        ));
      } on FirebaseAuthException catch (error) {
        setState(() {
          isAuthenticating = false;
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } else {
      try {
        setState(() {
          isAuthenticating = true;
        });
        setState(() {
          isAuthenticating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User Account Created Sucessfully")));
        setState(() {
          isLogin = !isLogin;
        });
      } on FirebaseAuthException catch (error) {
        setState(() {
          isAuthenticating = false;
        });
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  //UI Part of Login and Sigup Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 400,
                    child: Card(
                        color: Colors.black45,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('lib/assets/KodersLogo.png'),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 350,
                  height: 600,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 20,
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              onSaved: (newValue) {
                                emailid = newValue!;
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter a valid e-mail';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              // controller: emailid,
                              decoration: InputDecoration(
                                  labelText: "E-Mail",
                                  // labelStyle: ,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "abc@xyz.com"),
                            ),
                          ),
                          if (!isLogin)
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                onSaved: (newValue) {
                                  uname = newValue!;
                                },
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a valid username';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                // controller: emailid,
                                decoration: InputDecoration(
                                    labelText: "Username",
                                    // labelStyle: ,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "john123"),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              onSaved: (newValue) {
                                pass = newValue!;
                              },
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Password length should be greater than 6';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              // controller: pass,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  // labelStyle: ,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "🤫🪪"),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(20),
                              child: !isAuthenticating
                                  ? SizedBox(
                                      width: 100,
                                      height: 40,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                          onPressed: onSubmit,
                                          child: isLogin
                                              ? const Text('Log In')
                                              : const Text('Sign Up')),
                                    )
                                  : const CircularProgressIndicator()),
                          if (!isAuthenticating)
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    isLogin = !isLogin;
                                  });
                                },
                                child: Text(isLogin
                                    ? 'Create an Account'
                                    : 'Already have an account')),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
