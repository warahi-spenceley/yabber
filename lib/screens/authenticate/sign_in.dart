import 'package:flutter/material.dart';
import 'package:yabber/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  const SignIn({Key? key,  required this.toggleView }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  // Text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in to Yabber'),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.person), 
            label: const Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                onChanged: (value) => {
                  setState(() => email = value)
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                onChanged: (value) => {
                  setState(() => password = value)
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Sign in'),
                onPressed: () async {
                  print(email);
                  print(password);
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Continue as guest'),
                onPressed: () async {
                  dynamic result = await _auth.signInAnon();
                  if (result == null) {
                    print('error signing in');
                  } else {
                    print('Successfully signed in');
                    print(result.uid);
                  }
                },
              ),
            ],
          )
        )
      ),
    );
  }
}