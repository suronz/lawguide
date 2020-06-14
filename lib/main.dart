import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:law_guide/authenticate/authenticate.dart';
import 'package:law_guide/dashboard.dart';
import 'package:law_guide/glogin.dart';
import 'package:law_guide/services/auth_service.dart';
import 'package:law_guide/uRegister.dart';
import 'package:law_guide/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';


// // void main() => runApp(MyApp());

// bool _newNotification = false;

// void main() async {
//   // Set default home.
//   WidgetsFlutterBinding.ensureInitialized();
//   Widget _defaultHome = LogIn();

//   // Get result of the login function.
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//     final prefData = prefs.getBool('KeepMeLoggedIn') ?? false;  
//     print(prefData);
//     if(_newNotification == false){
//       //if(lat != null){
//         if (prefData) {
//           _defaultHome =  Dashboard();
//         }else{
//           _defaultHome =  UserRegister();
//         }
//       // }else{
//       //   AlertDialog(title: _defaultHome,);
//       // }
      
//     }else{
//       //if notification coming from FCM
//     }
 

//   // Run app!
//   runApp(new MaterialApp(
//     title: 'Law Guide App',
//     theme: ThemeData(primaryColor: Colors.indigo),
//     home: _defaultHome,
//     routes: <String, WidgetBuilder>{
//       // Set routes for using the Navigator.
//       '/home': (BuildContext context) =>  Dashboard(),
//       '/login': (BuildContext context) =>  LogIn(),
//       '/uregister':(BuildContext context) => UserRegister(),
//     },
//   ));
// }
// //}



void main() async { 
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_){
    runApp(MyApp());
    });
  }
// });


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
     MultiProvider(
          providers: [
            Provider<User>(
              create: (_) => User(),
            ),
            Provider<GoogleLoginService>(
              create: (_) => GoogleLoginService(),
            ),
          ],
    child: StreamProvider<User>.value(
        value: GoogleLoginService().currentUser,
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // hintColor: Color(0xFFC0F0E8),
            primaryColor:  Color(0xff00a79b),
            focusColor:  Color(0xff00a79b),
            // canvasColor: Colors.transparent),
          ),
            // fontFamily: "Montserrat",
          home: Wrapper(),
          routes: <String, WidgetBuilder>{
           // Set routes for using the Navigator.
            Dashboard.id : (BuildContext context) =>  Dashboard(),
            Authenticate.id : (BuildContext context) =>  Authenticate(),
            UserRegister.id : (BuildContext context) => UserRegister(),
          },
        ),
        
        ),
     );

    
  }
}