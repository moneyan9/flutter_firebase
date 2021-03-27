import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/chat_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String infoText = '';
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(infoText),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Sign up'),
                    onPressed: () async {
                      try {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final result =
                            await auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return ChatPage(result.user);
                          }),
                        );
                      } catch (e) {
                        setState(() {
                          infoText = "Failed：${e.toString()}";
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    child: Text('Sign in'),
                    onPressed: () async {
                      try {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final result = await auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return ChatPage(result.user);
                          }),
                        );
                      } catch (e) {
                        setState(() {
                          infoText = "Failed：${e.toString()}";
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
