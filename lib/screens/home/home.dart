import 'package:flutter/material.dart';
import 'package:yabber/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Yabber'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.person),
            onPressed: () async { await _auth.signOut(); },
            label: const Text('Logout')
          )
        ],
      ),
    );
  }
}