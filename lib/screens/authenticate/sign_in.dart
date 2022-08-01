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
  final _formKey = GlobalKey<FormState>();

  // Text field state
  String email = '';
  String password = '';
  String error = '';

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
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (dynamic value) => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) ? null : "Please enter a valid email.",
                onChanged: (value) => {
                  setState(() => email = value)
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (dynamic value) => value.length < 6 ? "Your password will be atleast 6 characters long." : null,
                obscureText: true,
                onChanged: (value) => {
                  setState(() => password = value)
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Sign in'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null){
                      setState(() => error = 'Oops something went wrong.');
                    }
                  }
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Continue as guest'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    dynamic result = await _auth.signInAnon();
                    if (result == null){
                      setState(() => error = 'Oops something went wrong.');
                    }
                  }
                },
              ),
              const SizedBox(height: 12.00),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          )
        )
      ),
    );
  }
}