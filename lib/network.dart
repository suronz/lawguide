import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FetchApis {

  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'profile',
      'email',   
    ]
);

  String baseurl = 'http://lawyerguid-dev.us-east-1.elasticbeanstalk.com/api/Users/';
  static const headers = {"Content-Type": "application/json"};

  Future checkUserbyMail(user) async {
  print(user);
    var requestforEmail = {};
    requestforEmail["MailID"] = user['email'];
    
    String enrequestforemail = base64Encode(requestforEmail);
    // print(enrequestforemail);
    String body =  "{\"request\": $enrequestforemail}";
    
    try{

      http.Response resp = await http.post(baseurl + 'UserbyMail',headers:headers,body:body);
      return resp;

    }catch(e){
      print(e.toString());
    }


  }

    // Future<void> handleSignOut() async{
    //       try{
    //         final prefs = await SharedPreferences.getInstance();
            
    //         await _googleSignIn.disconnect().then((onValue){
    //           print(onValue);
    //         });
    //         prefs.setBool('KeepMeLoggedIn', false);

    //       }catch(error){
    //         print(error);
    //       }
    //   }

    Future registerUser(userdetails) async{

       print(userdetails);
    var requestforRegisterUser = {
      "Username":userdetails['username'],
      "Mobile":userdetails['mobile'],
      "Mail":userdetails['email'],
      "Country":userdetails['country'],
      "State":userdetails['state'],
      "City":userdetails['city'],
      "Pincode":userdetails['pincode'],
      "Usertype":"U",
      "Image":"",
      "Occuption":"",
      "OccuptionID":0,
      "ID":"",
    };
    // requestforRegisterUser["MailID"] = userdetails['email'];
    
    String enrequestforemail = base64Encode(requestforRegisterUser);
    // print(enrequestforemail);
    String body =  "{\"request\": $enrequestforemail}";
    
    try{

      http.Response resp = await http.post(baseurl + 'RegisterUser',headers:headers,body:body);
      return resp;

    }catch(e){
      print(e.toString());
    }



    }

      String base64Encode(request){
        String cnvrttobase64 = base64.encode(utf8.encode(json.encode(request)));
        String response = json.encode(cnvrttobase64);
        return response;
      }

      base64Decode(request){
         var getuserbymail =utf8.decode(base64.decode(request));
          var response = jsonDecode(getuserbymail);
          return response;
      }



}