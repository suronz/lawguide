import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:law_guide/dashboard.dart';
import 'package:law_guide/models/user.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';


class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    print(user);
    ScreenUtil.init(context, width: 393, height: 873, allowFontScaling: true);

    if(user ==  null){
      return Authenticate();
    }
    else{
      return Dashboard();
    }
    
  }
}