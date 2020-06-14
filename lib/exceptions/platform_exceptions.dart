import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:law_guide/exceptions/platform_alert_dialogue.dart';

class PlatFormExceptionAlertDialog extends PlatformAlertDialog {
    PlatFormExceptionAlertDialog({
      @required String title, 
      @required PlatformException exception
    }): super(
      title:title,
      content : _message(exception),
      defaultActionText : 'OK',
    );

    static String _message(PlatformException exception){
      return _errors[exception.code] ?? exception.message;
    }

  static Map<String,String> _errors = {
    'ERROR_WEAK_PASSWORD': 'The password is not strong enough.',
    'ERROR_INVALID_EMAIL' : 'The email address is malformed.',
    'ERROR_EMAIL_ALREADY_IN_USE' : 'The email is already in use by a different account.',
    'ERROR_INVALID_CREDENTIAL' :'The [email] address is malformed.',
    'ERROR_USER_NOT_FOUND' : 'There is no user corresponding to the given [email] address.',
    'ERROR_NOT_ALLOWED' : 'Indicates that email and email sign-in link accounts are not enabled. Enable them in the Auth section of the Firebase console.',
    'ERROR_DISABLED' : "Indicates the user's account is disabled.",
    'ERROR_INVALID' : 'Indicates the email address is invalid.',
  };
}