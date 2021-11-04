import 'package:form_field_validator/form_field_validator.dart';
import 'package:user_authentication_example/resources/strings.dart';

class TextFieldValidator {
  TextFieldValidator._internal();

  factory TextFieldValidator() {
    return TextFieldValidator._internal();
  }

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: requiredPassword),
    MinLengthValidator(8, errorText: requiredEightDigitsInPassword),
    PatternValidator(r'(?=.*?[#?!@$%^&*.-])',
        errorText: requiredSpecialCharacterInPassword),
    PatternValidator(r'(?=.*[A-Z])',
        errorText: requiredUpperCaseLetterInPassword),
    PatternValidator(r'(?=.*[0-9])', errorText: requiredNumberInPassword),
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: requiredEmail),
    EmailValidator(errorText: invalidEmail)
  ]);



}
