// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:law_guide/dashboard.dart';
import 'package:law_guide/models/user.dart';
import 'package:law_guide/network.dart';
import 'package:law_guide/services/auth_service.dart';
import 'package:law_guide/uRegister.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


User user = User();

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  // GoogleSignInAccount _currentUser;
  FetchApis fetch = FetchApis();

  // @override
  // void initState() {
  //   super.initState();
  //   _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
  //       setState(() {
  //         _currentUser = account;
  //         // print(_currentUser);
  //       });
  //   });
  //   _googleSignIn.signInSilently();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Law Guide')
      ),
      body: Container(
         padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        
          child:_buildBody(),
        ),
      );
    }
      
     Widget _buildBody() {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('You are not Signed In!'),
                RaisedButton(onPressed:_handleSignIn,
                  child: Text(
                    'Sign In with Google!'
                  ),
                )
              ],
            ),
          );
        }
      // }

   Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

      Future<void> _handleSignIn() async{
          try{
            final prefs = await SharedPreferences.getInstance();
            
            final auth = Provider.of<GoogleLoginService>(context,listen: false);
            final resp =  await auth.handleSignIn();
            
            print(resp.body);
            if(resp.statusCode == 200){
              var decodedData = fetch.base64Decode(resp.body);
              // print(decodedData);
              if(decodedData['ReturnCode'] == 0){
                Navigator.pushNamed(context, Dashboard.id);
              }
              else if(decodedData['ReturnCode'] == 302){
                Navigator.pushNamed(context, UserRegister.id);
                print('User not exists!');
              }else{
                print('Something went wrong!');
              }
              
            }else{
              print('Something went wrong!');
            }
          
          }catch(error){
            print(error);
          }
      }
    
}