import 'package:firebase_login/screen/LoginSceen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginChoice extends StatefulWidget {
  const LoginChoice({super.key});

  @override
  State<LoginChoice> createState() => _LoginChoiceState();
}

//clientID, and redirectUri is defined same, as set in whop account.
const clientId = 'fQ5XovE4dVYSc2HHHHeuenpImKyQ3ek3l0E-xlerb14';
const redirectUri = 'https://domain.com/oauth/callback';

//this function redirects to OAuth with Google,Discord, etc.
void _loginWithWhop() async {
  final url =
      'https://whop.com/oauth/discord?wa=discordclient_id=$clientId&redirect_uri=$redirectUri';
  final Uri _url = Uri.parse(url);
  launchUrl(_url, mode: LaunchMode.externalApplication);
}

class _LoginChoiceState extends State<LoginChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Whop Oauth"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
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
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Choose Login Option",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 5),
                onPressed: _loginWithWhop,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Whop OAuth Login",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 5),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Login with Email & Password using Firebase",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
