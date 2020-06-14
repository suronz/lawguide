import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:law_guide/custom_widgets/submit_button.dart';
import 'package:law_guide/dashboard.dart';
import 'package:law_guide/exceptions/platform_exceptions.dart';
import 'package:law_guide/models/registeruser.dart';
import 'package:law_guide/models/user.dart';
import 'package:law_guide/network.dart';
import 'package:law_guide/services/auth_service.dart';
import 'package:law_guide/validators.dart';
import 'package:provider/provider.dart';

class UserRegister extends StatefulWidget with EmailAndPasswordProviders{

  static String id = 'userRegister';
  
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {

   final _signupScaffold = GlobalKey<ScaffoldState>();

   FetchApis fetch = FetchApis();

  final TextEditingController usernamecontrol = TextEditingController();
  final TextEditingController pincodecontrol = TextEditingController();
  final TextEditingController emailcontrol = TextEditingController();
  final TextEditingController countrycontrol = TextEditingController();
  final TextEditingController citycontrol = TextEditingController();
  final TextEditingController statecontrol = TextEditingController();
  final TextEditingController mobileControl = TextEditingController();

   String get _email => emailcontrol.text;
   String get _pincode => pincodecontrol.text;
   String get _username => usernamecontrol.text;
   String get _country => countrycontrol.text;
   String get _city => citycontrol.text;
   String get _mobileno => mobileControl.text;
   String get _state => statecontrol.text;
  

    bool emailValid =true;
    bool pincodevalid = true;
    bool usernamevalid = true;
    bool countryvalid = true;
    bool cityvalid = true;
    bool statevalid = true;
    bool mobilevalid = true;

    bool loading = false;
  
    _onSubmit() async {
    var dontproceed = true;

    if(_email.isEmpty){
      setState(() {
        emailValid = false;
      });
      
      dontproceed =false;

    }
    if( _pincode.isEmpty){
       setState(() {
        pincodevalid = false;
      });
     dontproceed =false;
    }
    if(_username.isEmpty){
       setState(() {
        usernamevalid = false;
      });
       dontproceed =false;
    }
    if(_city.isEmpty){
       setState(() {
        cityvalid = false;
      });
       dontproceed =false;
    }
    if(_country.isEmpty){
      setState(() {
        countryvalid = false;
      });
       dontproceed =false;
    }
    if(_mobileno.isEmpty || _mobileno.length < 10){
      setState(() {
        mobilevalid = false;
      });
       dontproceed =false;
    }
    if(_state.isEmpty){
      setState(() {
        statevalid = false;
      });
       dontproceed =false;
    }

    if(dontproceed){
      setState(() {
         loading = true;
      });
     
    try{
      final _auth = Provider.of<GoogleLoginService>(context,listen: false);
      // final user = Provider.of<User>(context,listen: false);
      
        RegisterUser userDetails = RegisterUser(
            username : _username,
            country: _country,
            email: _email,
            pincode: _pincode,
            city: _city,
            state: _state,
            mobile : _mobileno,
            id: "",

        );
     
      final ifRegister = await _auth.registerUser(userDetails);
      var resp = ifRegister;

      if(resp.statusCode == 200){
              var decodedData = fetch.base64Decode(resp.body);
              // print(decodedData);
              if(decodedData['ReturnCode'] == 0){
                Navigator.pushNamed(context, Dashboard.id);
              
              }else{
                print(decodedData);
                print('Something went wrong!');
              }
              
            }else{
              print(resp.body);
              print('Something went wrong!');
            }

    
    }on PlatformException catch(e){
        PlatFormExceptionAlertDialog(
        exception: e,  
        title: 'Sign UP failed',
        ).show(context);
        print(e); // print(e);
        setState(() {
         loading = false;
      });
    }finally{
      setState(() {
         loading = false;
        
      });
    }

    }

  }

   @override
  void dispose() {
    // _emailController.dispose();
    // _passwordController.dispose();
    // _emailFocusNode.dispose();
    // _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
      key: _signupScaffold,
      backgroundColor: Colors.white,
      appBar: AppBar(actions: <Widget>[],
        title:Text('HomePage',style: TextStyle(color: Colors.white,
        fontSize: ScreenUtil().setSp(15),
        fontWeight: FontWeight.bold,
        )),
        backgroundColor: Color(0xff00a79b),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: ScreenUtil().setWidth(393),
            height: ScreenUtil().setWidth(800),
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              shape: BoxShape.rectangle, 
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(30.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                    SizedBox(
                      width: ScreenUtil().setWidth(270),
                      child: TextField(
                        controller: usernamecontrol,
                        inputFormatters:[
                          LengthLimitingTextInputFormatter(15),
                        ],
                          onChanged: (val){
                            if(val != ''){
                            setState(() {
                              usernamevalid = true;
                            });
                          }
                        },
                        decoration: InputDecoration(
                        hintText: 'UserName',
                        errorText: usernamevalid ? null : widget.usernameError,
                          hintStyle: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: ScreenUtil().setWidth(270),
                    child: TextField(
                      inputFormatters:[
                        LengthLimitingTextInputFormatter(30),
                      ],
                      controller: emailcontrol,
                      onChanged: (val){
                          if(val.isNotEmpty){
                          setState(() {
                            emailValid = true;
                          });
                        }
                        },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                      hintText: 'Email',
                      errorText: emailValid ? null :  widget.emailerror,
                        hintStyle: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(270),
                    child: TextField(
                      inputFormatters:[
                        LengthLimitingTextInputFormatter(15),
                      ],
                      onChanged: (val){
                        if(val.isNotEmpty){
                          setState(() {
                            countryvalid = true;
                          });
                        }
                      },
                      controller: countrycontrol,
                      // obscureText: true,
                      decoration: InputDecoration(
                      hintText: 'Country',
                      errorText: countryvalid ? null : widget.countryError,
                        hintStyle: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(270),
                      child: TextField(
                        inputFormatters:[
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: statecontrol,
                          onChanged: (val){
                            if(val.isNotEmpty){
                              setState(() {
                                statevalid = true;
                              });
                            }
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                          hintText: 'State',
                          errorText: statevalid ? null :  widget.stateError,
                            hintStyle: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
          
                    
                  SizedBox(
                        width: ScreenUtil().setWidth(270),
                        child: TextField(
                          inputFormatters:[
                              LengthLimitingTextInputFormatter(20),
                            ],
                            decoration:  InputDecoration(
                              errorText: cityvalid ? null :  widget.cityError,
                                border:  OutlineInputBorder(

                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenUtil().setWidth(10)),
                                  ),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                hintText: "City",
                                fillColor: Colors.white70),
                                controller: citycontrol,
                                keyboardType: TextInputType.text,
                                onChanged: (val){
                                  if(val.isNotEmpty){
                                    setState(() {
                                      cityvalid = true;
                                    });  
                                  }
                                },
                          ),
                      ),
                      // SizedBox(height: 10,),
                      SizedBox(
                        width: ScreenUtil().setWidth(270),
                        child: TextField(
                          inputFormatters:[
                            LengthLimitingTextInputFormatter(10),
                          ],
                          controller: mobileControl,
                          onChanged: (val){
                              if(val.isNotEmpty){
                              setState(() {
                                mobilevalid = true;
                              });
                            }
                            },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                          hintText: 'Mobile no',
                          errorText: mobilevalid ? null :  widget.mobileError,
                            hintStyle: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                      width: ScreenUtil().setWidth(270),
                      child: TextField(
                        inputFormatters:[
                          LengthLimitingTextInputFormatter(15),
                        ],
                        controller: pincodecontrol,
                          onChanged: (val){
                            if(val.isNotEmpty){
                            setState(() {
                              pincodevalid = true;
                            });
                          }
                        },
                        decoration: InputDecoration(
                        hintText: 'Pincode',
                        errorText: pincodevalid ? null : widget.pincodeError,
                          hintStyle: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  
                  
                  FormSubmitButton(buttonType: 'SIGN UP', onPressed: _onSubmit)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  
  }
}