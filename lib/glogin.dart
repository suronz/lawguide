import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GoogleLogin extends StatefulWidget {
  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
            child: RaisedButton(onPressed: callGoogelService,color: Colors.red,
                child: Text("Google Login", style: TextStyle(color: Colors.white),)
                                           
            ),
            splashColor: Colors.white, // inkwell color
        ),
                                      
      ),
    );
  }

  callGoogelService(){

      Fluttertoast.showToast(
            msg: 'No internet connection. But your attendance has been recorded successfully',
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIos: 1,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black54,
            fontSize: 12.0,
        );
  }
}