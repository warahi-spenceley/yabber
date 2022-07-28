import 'package:flutter/material.dart';
import 'package:yabber/models/AuthenticatedUser.dart';
import 'package:yabber/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:yabber/services/auth.dart';
import 'models/AuthenticatedUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthenticatedUser?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, __) => null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}