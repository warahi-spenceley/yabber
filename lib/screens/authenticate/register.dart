import 'package:flutter/material.dart';
import 'package:yabber/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  const Register({Key? key,  required this.toggleView }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
        title: const Text('Register for Yabber'),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.person), 
            label: const Text('Sign In'),
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
                validator: (dynamic value) => value.length < 6 ? "Please make sure your password is atleast 6 characters long." : null,
                obscureText: true,
                onChanged: (value) => {
                  setState(() => password = value)
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text('Register'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
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