import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return MaterialApp(
      title: 'Stone Age',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
