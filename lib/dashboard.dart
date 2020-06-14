import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:law_guide/models/user.dart';
import 'package:law_guide/network.dart';
import 'package:law_guide/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Dashboard extends StatefulWidget {

  static String id = 'dashboard';

  @override
  _DashboardState createState() => _DashboardState();


}

class _DashboardState extends State<Dashboard> {
 
 

  @override
  Widget build(BuildContext context) {

    
 final user = Provider.of<GoogleLoginService>(context);
    return Scaffold(
       appBar: new AppBar(
          title: new Text('Dashboard'),
          actions: <Widget>[
            IconButton(icon: 
             Icon(Icons.menu,
            ),
            onPressed:() => user.handleSignOut()),
          ],
        ),
    );
  }
 
}