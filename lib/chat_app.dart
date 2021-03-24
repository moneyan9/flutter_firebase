import 'package:flutter/material.dart';
import 'package:flutter_firebase/login_page.dart';

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'ChatApp',
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.lightBlue,
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
        ),
        home: LoginPage(),
      );
}
