import 'package:flutter/material.dart';
import 'package:law_guide/glogin.dart';


class Authenticate extends StatefulWidget {

  static String id = 'authenticate';
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LogIn(),
    );
  }
}