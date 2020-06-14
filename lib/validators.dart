abstract class StringValidator {
  bool isValid(String value);
}

class NonemptyStringValidators implements StringValidator{
  @override
  bool isValid(String value){
    return value.isNotEmpty;
  }
}

class EmailAndPasswordProviders {
  final StringValidator emailValidator = NonemptyStringValidators();
  final StringValidator passwordValidator = NonemptyStringValidators();
  final String emailerror = 'Email can\'t be empty';
  final String usernameError = 'Username can\'t be empty';
  final String pincodeError = 'Pincode can\'t be empty';
  final String stateError = 'State can\'t be empty';
  final String countryError = 'Invalid Country';
  final String mobileError = 'Invalid MobileNo';
  final String cityError = 'City can\'t be empty';
}