import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:law_guide/exceptions/platform_widgets.dart';

class PlatformAlertDialog extends PlatformWidget {

  PlatformAlertDialog({@required this.content,@required this.defaultActionText,@required this.title,this.cancelActionText})
  : assert(title != null),assert(defaultActionText != null),assert(content != null);


  final String title;
  final String content;
  final String cancelActionText;
  final String defaultActionText;

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS 
    ? await showCupertinoDialog(
      context: context, builder: (context) => this,
      )
    : await showDialog<bool>( 
        context:context,
        builder:(context) => this,
      );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    
    return CupertinoAlertDialog(
      title:Text(
              title,
            ),
            content: Text(content),
            actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    
    return AlertDialog(
            title:Text(
              title,
            ),
            content: Text(content),
            actions: _buildActions(context),
          );
  }

  List <Widget> _buildActions(BuildContext context){
    final actions = <Widget>[];
    if(cancelActionText != null){
      actions.add(
          PlatformAlertDialogAction(onPressed: () => Navigator.of(context).pop(false), child: Text('OK')),
      );
    }
    actions.add(
      PlatformAlertDialogAction(onPressed: () => Navigator.of(context).pop(true), child: Text('OK')),
    );      
    
  }

}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({this.child,this.onPressed});
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(child: child,onPressed:onPressed);
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(child: child,onPressed:onPressed);
  }
}