import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthUser extends StatefulWidget {
  @override
  _AuthUserState createState() => _AuthUserState();
}

class _AuthUserState extends State<AuthUser> {
//  login() {
//    googleSignIn.signIn();
//  }

//  @override
//  void initState() {
//    super.initState();
//    googleSignIn.onCurrentUserChanged.listen((account) {
//      if (account != null) {
//        print('User signed in: $account');
//        Navigator.pushNamed(context, '/todos');
//      } else {
//        print('not signed in.');
//      }
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'TodoList',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: FlatButton(
                    onPressed: () {
                      //login();
                      Navigator.pushNamed(context, '/todos');
                    },
                    child: ListTile(
                      leading: Icon(FontAwesomeIcons.bookOpen),
                      title: Text(
                        'Open Your list',
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Icon(FontAwesomeIcons.arrowRight),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
              ),
              Text(
                'Copyright © 2019 Pritimoy Paul',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}
