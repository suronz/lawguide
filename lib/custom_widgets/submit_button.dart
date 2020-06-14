import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormSubmitButton extends StatelessWidget {
  
  final Function onPressed;
  final String buttonType; 

  FormSubmitButton({@required this.buttonType, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(60.0),
      width: ScreenUtil().setWidth(330),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.indigo,
        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(5.0))),
      ),
        child: Material(
          color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: Colors.white,
          child: Center(child: Text(buttonType,style: TextStyle(
            color:Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: ScreenUtil().setSp(24.0),
            letterSpacing: ScreenUtil().setWidth(3.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}