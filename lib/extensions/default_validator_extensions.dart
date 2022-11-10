import 'package:fluent_validation/abstract/abstract_rule_builder.dart';
import 'package:fluent_validation/enum/validation_enum.dart';
import 'package:fluent_validation/model/validator_info.dart';

import '../abstract/abstract_validator.dart';
import '../fluent_validation.dart';
import '../model/stream_validator.dart';

extension DefaultValidatorExtensions on AbstractRuleBuilder {
  AbstractRuleBuilder matches(String expression) {
    var _selectedRegExp = RegExp(expression);

    streamValidator.innerStream.listen(
      (event) {
        if (!_selectedRegExp.hasMatch(event)) {
          streamValidator.streamSink
              .addError(_getErrorMessage(ValidationTagEnum.MATCHES));
        } else {
          streamValidator.streamSink.addError(ValidationEnum.validated);
          streamValidator.streamSink.add(event);
        }
      },
    );

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value is not matches",
        validationTagEnum: ValidationTagEnum.MATCHES));

    return this;
  }

  AbstractRuleBuilder emailAddress() {
    var _selectedRegExp = RegExp(
        '^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})\$');

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
        errorMessage: "email should be valid",
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
        errorMessage: "value is Number",
        validationTagEnum: ValidationTagEnum.SHOULD_BE_NUMBER));
    return this;
  }

  AbstractRuleBuilder between(int from, int to) {
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
        errorMessage: "value should be between ${from} and ${to}",
        validationTagEnum: ValidationTagEnum.BETWEEN));

    return this;
  }

  AbstractRuleBuilder notEmpty() {
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
        errorMessage: "value should not be empty",
        validationTagEnum: ValidationTagEnum.NOT_EMPTY));

    return this;
  }

  AbstractRuleBuilder isNull() {
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
        errorMessage: "value is not  null",
        validationTagEnum: ValidationTagEnum.IS_NULL));

    return this;
  }

  AbstractRuleBuilder isNotNull() {
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
        errorMessage: "value is   null",
        validationTagEnum: ValidationTagEnum.IS_NOT_NULL));
    return this;
  }

  AbstractRuleBuilder isEmpty() {
    streamValidator.innerStream.listen((event) {
      if ("${event}".isEmpty) {
        streamValidator.streamSink
            .addError(_getErrorMessage(ValidationTagEnum.EMPTY));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value is not empty",
        validationTagEnum: ValidationTagEnum.EMPTY));

    return this;
  }

  AbstractRuleBuilder
      notEqual<TProperty extends StreamValidator, T extends Object>(
          TProperty Function(AbstractValidator<T>) expression) {
    var fromStreamValidator = create(expression);

    streamValidator.innerStream.listen((event) {
      if (event == fromStreamValidator.value) {
        streamValidator.streamSink
            .addError(_getErrorMessage(ValidationTagEnum.NOT_EQUAL));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should not Equal",
        validationTagEnum: ValidationTagEnum.NOT_EQUAL));

    return this;
  }

  AbstractRuleBuilder
      equal<TProperty extends StreamValidator, T extends Object>(
          TProperty Function(AbstractValidator<T>) expression) {

    var fromStreamValidator =
        expression(abstractValidator as AbstractValidator<T>);

    streamValidator.innerStream.listen((event) {
      if (event == fromStreamValidator.value) {
        streamValidator.streamSink
            .addError(_getErrorMessage(ValidationTagEnum.EQUAL));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should be Equal",
        validationTagEnum: ValidationTagEnum.EQUAL));

    return this;
  }

  AbstractRuleBuilder withMessage(Object errorMessage) {
    if (validatorInfoList.isEmpty) {
      throw Exception("should add rule before with message");
    }

    validatorInfoList[validatorInfoList.length - 1] = ValidatorInfo(
        validationTagEnum:
            validatorInfoList[validatorInfoList.length - 1].validationTagEnum,
        errorMessage: errorMessage);

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

  StreamValidator create<TProperty extends StreamValidator, T extends Object>(
      TProperty Function(T) expression) {
    try {
      var instanceOfT = getIt.get<T>();

      return expression(instanceOfT);
    } catch (e) {
      throw Exception(
          'To use this library you should add get it to your objects.');
    }
  }
}
