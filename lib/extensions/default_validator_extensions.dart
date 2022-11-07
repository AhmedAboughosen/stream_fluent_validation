import 'package:fluent_validation/abstract/abstract_rule_builder.dart';
import 'package:fluent_validation/enum/validation_enum.dart';
import 'package:fluent_validation/extensions/validator_info_extensions.dart';
import 'package:fluent_validation/model/validator_info.dart';

extension DefaultValidatorExtensions on AbstractRuleBuilder {
  AbstractRuleBuilder matches(String expression) {
    var _selectedRegExp = RegExp(expression);

    print("matches expression");

    streamValidator.innerStream.listen(
      (event) {
        print("innerStream");

        if (!_selectedRegExp.hasMatch(event)) {
          print("not match");
          streamValidator.streamSink
              .addError(_getErrorMessage(ValidationTagEnum.MATCHES));
        } else {
          print(" match");

          streamValidator.streamSink.addError(ValidationEnum.validated);
          streamValidator.streamSink.add(event);
        }
      },
    );

    validatorInfoList.add(ValidatorInfo(
        errorMessage: null, validationTagEnum: ValidationTagEnum.MATCHES));

    return this;
  }

  AbstractRuleBuilder emailAddress() {
    var _selectedRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");

    streamValidator.innerStream.listen((event) {
      if (!_selectedRegExp.hasMatch(event)) {
        streamValidator.streamSink
            .addError(_getErrorMessage(ValidationTagEnum.EMAIL_ADDRESS));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    validatorInfoList.add(ValidatorInfo(
        errorMessage: null,
        validationTagEnum: ValidationTagEnum.EMAIL_ADDRESS));

    return this;
  }

  AbstractRuleBuilder shouldBeNumber() {
    var _selectedRegExp = RegExp(r'^[0-9]+$');

    streamValidator.innerStream.listen((event) {
      if (!_selectedRegExp.hasMatch(event)) {
        streamValidator.streamSink
            .addError(_getErrorMessage(ValidationTagEnum.SHOULD_BE_NUMBER));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    validatorInfoList.add(ValidatorInfo(
        errorMessage: null,
        validationTagEnum: ValidationTagEnum.SHOULD_BE_NUMBER));
    return this;
  }

  void between(int from, int to) {
    streamValidator.innerStream.listen((event) {
      String value = event;

      if (!(value.length >= from && value.length <= to)) {
        streamValidator.streamSink
            .addError(_getErrorMessage(ValidationTagEnum.BETWEEN));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    validatorInfoList.add(ValidatorInfo(
        errorMessage: null,
        validationTagEnum: ValidationTagEnum.EMAIL_ADDRESS));
  }

  void notEmpty() {
    var _selectedRegExp = RegExp('^\\w{1,1}\$');

    streamValidator.innerStream.listen((event) {
      if (!_selectedRegExp.hasMatch(event)) {
        streamValidator.streamSink
            .addError(_getErrorMessage(ValidationTagEnum.NOT_EMPTY));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    validatorInfoList.add(ValidatorInfo(
        errorMessage: null, validationTagEnum: ValidationTagEnum.NOT_EMPTY));
  }

  void isNull() {
    streamValidator.innerStream.listen(
      (event) {
        if (event != null) {
          streamValidator.streamSink
              .addError(_getErrorMessage(ValidationTagEnum.IS_NULL));
        } else {
          streamValidator.streamSink.addError(ValidationEnum.validated);
          streamValidator.streamSink.add(event);
        }
      },
    );

    validatorInfoList.add(ValidatorInfo(
        errorMessage: null, validationTagEnum: ValidationTagEnum.IS_NULL));
  }

  void isNotNull() {
    streamValidator.innerStream.listen(
      (event) {
        if (event == null) {
          streamValidator.streamSink
              .addError(_getErrorMessage(ValidationTagEnum.IS_NOT_NULL));
        } else {
          streamValidator.streamSink.addError(ValidationEnum.validated);
          streamValidator.streamSink.add(event);
        }
      },
    );

    validatorInfoList.add(ValidatorInfo(
        errorMessage: null, validationTagEnum: ValidationTagEnum.IS_NOT_NULL));
  }

  void empty() {
    streamValidator.innerStream.listen((event) {
      if (event != '') {
        streamValidator.streamSink
            .addError(_getErrorMessage(ValidationTagEnum.EMPTY));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    validatorInfoList.add(ValidatorInfo(
        errorMessage: null, validationTagEnum: ValidationTagEnum.EMPTY));
  }

  void notEqual() {
    streamValidator.innerStream.listen((event) {
      if (streamValidator.value == event) {
        streamValidator.streamSink
            .addError(_getErrorMessage(ValidationTagEnum.NOT_EQUAL));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    validatorInfoList.add(ValidatorInfo(
        errorMessage: null, validationTagEnum: ValidationTagEnum.NOT_EQUAL));
  }


  void equal() {
    streamValidator.innerStream.listen((event) {
      if (streamValidator.value != event) {
        streamValidator.streamSink
            .addError(_getErrorMessage(ValidationTagEnum.EQUAL));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    validatorInfoList.add(ValidatorInfo(
        errorMessage: null, validationTagEnum: ValidationTagEnum.EQUAL));
  }

  AbstractRuleBuilder withMessage(Object errorMessage) {
    if (validatorInfoList.isEmpty) {
      throw Exception("should add rule before with message");
    }

    for (var i = validatorInfoList.length - 1; i >= 0; --i) {
      if (validatorInfoList[i].errorMessage == null) {
        validatorInfoList[i].copyWith(newErrorMessage: errorMessage);
        return this;
      }
    }
    return this;
  }

  String _getErrorMessage(ValidationTagEnum validationTagEnum) {
    Object errorMessage = ValidationEnum.unValidated;
    for (var i = 0; i < validatorInfoList.length; ++i) {
      if (validatorInfoList[i].validationTagEnum == validationTagEnum) {
        errorMessage =
            validatorInfoList[i].errorMessage ?? ValidationEnum.unValidated;
        return errorMessage.toString();
      }
    }

    return errorMessage.toString();
  }
}
