import 'package:fluent_validation/abstract/abstract_validator.dart';
import 'package:fluent_validation/extensions/default_validator_extensions.dart';
import 'package:fluent_validation/model/stream_validator.dart';

class ChangePinController {
  final ChangePinValidation changePinValidation = ChangePinValidation();

  void changePin() {
    if (!changePinValidation.validate()) {
      print("you can not login");
      return;
    }
    print("your login succeed ");
  }
}

class ChangePinValidation extends AbstractValidator<ChangePinValidation> {
  StreamValidator<String> newPin = StreamValidator<String>();
  StreamValidator<String> confirmPin = StreamValidator<String>();

  ChangePinValidation() {
    ruleFor((e) => (e as ChangePinValidation).newPin)
        .isNotEmpty()
        .withMessage("new Pin should not be empty")
        .between(5, 6)
        .withMessage("new Pin should be valid !!.");

    ruleFor((e) => (e as ChangePinValidation).confirmPin)
        .equalTo((e) => (e as ChangePinValidation).newPin)
        .withMessage("confirm password not equal to password.");
  }
}
