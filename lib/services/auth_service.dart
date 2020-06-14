import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:law_guide/models/registeruser.dart';
import 'package:law_guide/models/user.dart';
import 'package:law_guide/network.dart';



abstract class AuthBase {
  Stream <User> get currentUser;
  Future handleSignIn();
  Future<void> handleSignOut();
  Future registerUser(udetails);
}

class GoogleLoginService implements AuthBase {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'profile',
      'email',   
    ]
);


FetchApis fetch = FetchApis();
User user = User();
RegisterUser rUsers = RegisterUser();

  User _userFromFirebase(GoogleSignInAccount currentuser) {
    if(currentuser == null){
      return null;
    }
    return User(uid:currentuser.id);
  }
 


  @override
  Future handleSignIn() async{

     final udetails = await _googleSignIn.signIn();

        User users = User(
          email: udetails.email,
          name: udetails.displayName,
          uid: udetails.id,
          profilePhoto: udetails.photoUrl,
        );
        print(udetails); 

        try {

          final signin = await fetch.checkUserbyMail(user.toMap(users));
          _userFromFirebase(udetails);
          return signin;

        }
        catch(e){
          print(e.toString());
        }
        

  }

  @override
  Future<void> handleSignOut() async{
    return await _googleSignIn.disconnect();
  }

  @override
  
  Stream<User> get currentUser {
    return _googleSignIn.onCurrentUserChanged.map(_userFromFirebase);
  }

  @override
  Future registerUser(userdetails) async{

        RegisterUser details = RegisterUser(
          state:userdetails.state,
          country:userdetails.country ,
            city: userdetails.city,
            pincode : userdetails.pincode,
            email: userdetails.email,
            mobile: userdetails.mobile,
        );

        try {

          final registers = await fetch.registerUser(rUsers.toMap(details));
          return registers;

        }
        catch(e){
          print(e.toString());
        }
       



  }
}