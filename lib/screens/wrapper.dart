import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yabber/models/AuthenticatedUser.dart';
import 'package:yabber/screens/authenticate/authenticate.dart';
import 'package:yabber/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthenticatedUser?>(context);
    
    return user != null ? Home() : const Authenticate();
  }
}