import 'package:flutter/material.dart';
import 'package:flutter_firebase/login_page.dart';

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'ChatApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      );
}
