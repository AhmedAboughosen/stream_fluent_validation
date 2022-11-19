import 'package:fluent_validation/abstract/abstract_validator.dart';
import 'package:fluent_validation/extensions/default_validator_extensions.dart';
import 'package:fluent_validation/model/stream_validator.dart';

class LoginController {
  final LoginValidation loginValidation = LoginValidation();

  void login() {
    if (!loginValidation.validate()) {
      print("you can not login");
      return;
    }
    print("your login succeed ");
  }
}

class LoginValidation extends AbstractValidator<LoginValidation> {
  StreamValidator<String> email = StreamValidator<String>();
  StreamValidator<String> password = StreamValidator<String>();

  LoginValidation() {
    ruleFor((e) => (e as LoginValidation).email)
        .isNotEmpty()
        .withMessage("email should not be empty")
        .emailAddress()
        .withMessage("email should be valid !!.");

    ruleFor((e) => (e as LoginValidation).password).between(3, 4);
  }
}
