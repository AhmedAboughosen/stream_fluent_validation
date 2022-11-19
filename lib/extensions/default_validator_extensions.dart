import 'package:fluent_validation/abstract/abstract_rule_builder.dart';
import 'package:fluent_validation/enum/validation_enum.dart';
import 'package:fluent_validation/model/validator_info.dart';

import '../abstract/abstract_validator.dart';
import '../model/between_number_validation.dart';
import '../model/compare_to_validation.dart';
import '../model/must_validation.dart';
import '../model/reg_rxp.dart';
import '../model/stream_validator.dart';

extension DefaultValidatorExtensions on AbstractRuleBuilder {
  void observe() {
    streamValidator.innerStream.listen(
      (event) {
        for (int i = 0; i < validatorInfoList.length; ++i) {
          ValidationTagEnum currentValidationTagEnum =
              validatorInfoList[i].validationTagEnum;

          switch (currentValidationTagEnum) {
            case ValidationTagEnum.MATCHES:
              {
                _sendEventToClient(i, event, ValidationTagEnum.MATCHES);
                break;
              }
            case ValidationTagEnum.EMAIL_ADDRESS:
              {
                _sendEventToClient(i, event, ValidationTagEnum.EMAIL_ADDRESS);
                break;
              }
            case ValidationTagEnum.SHOULD_BE_NUMBER:
              {
                _sendEventToClient(
                    i, event, ValidationTagEnum.SHOULD_BE_NUMBER);
                break;
              }
            case ValidationTagEnum.BETWEEN:
              {
                _sendEventToClient(i, event, ValidationTagEnum.BETWEEN);
                break;
              }
            case ValidationTagEnum.NOT_EMPTY:
              {
                _sendEventToClient(i, event, ValidationTagEnum.NOT_EMPTY);
                break;
              }
            case ValidationTagEnum.EMPTY:
              {
                _sendEventToClient(i, event, ValidationTagEnum.EMPTY);
                break;
              }
            case ValidationTagEnum.NOT_EQUAL:
              {
                _sendEventToClientForNotEqualConditions(
                    i, event, ValidationTagEnum.NOT_EQUAL);

                break;
              }
            case ValidationTagEnum.EQUAL:
              {
                _sendEventToClientForEqualConditions(
                    i, event, ValidationTagEnum.EQUAL);

                break;
              }
            case ValidationTagEnum.MUST:
              {
                _sendEventToClient(i, event, ValidationTagEnum.MUST);
                break;
              }
          }
        }
      },
    );
  }

  void _sendEventToClient(
      int index, Object event, ValidationTagEnum validationTagEnum) {
    var isValidated =
        validatorInfoList[index].abstractValidation.validate(event);
    if (!isValidated) {
      streamValidator.streamSink.addError(_getErrorMessage(validationTagEnum));
    } else {
      streamValidator.streamSink.addError(ValidationEnum.validated);
      streamValidator.streamSink.add(event);
    }
  }

  void _sendEventToClientForEqualConditions(
      int index, Object event, ValidationTagEnum validationTagEnum) {
    CompareToValidation compareToValidation =
        validatorInfoList[index].abstractValidation as CompareToValidation;

    var fromStreamValidator = compareToValidation.streamValidator;

    fromStreamValidator.innerStream.listen((event) {
      if (streamValidator.stateOfInnerStream != event) {
        streamValidator.streamSink
            .addError(_getErrorMessage(validationTagEnum));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    if (event != fromStreamValidator.stateOfInnerStream) {
      streamValidator.streamSink.addError(_getErrorMessage(validationTagEnum));
    } else {
      streamValidator.streamSink.addError(ValidationEnum.validated);
      streamValidator.streamSink.add(event);
    }
  }

  void _sendEventToClientForNotEqualConditions(
      int index, Object event, ValidationTagEnum validationTagEnum) {
    CompareToValidation compareToValidation =
        validatorInfoList[index].abstractValidation as CompareToValidation;

    var fromStreamValidator = compareToValidation.streamValidator;

    if (!fromStreamValidator.hasListener) {
      fromStreamValidator.innerStream.listen((event) {
        if (streamValidator.state == event) {
          streamValidator.streamSink
              .addError(_getErrorMessage(validationTagEnum));
        } else {
          streamValidator.streamSink.addError(ValidationEnum.validated);
          streamValidator.streamSink.add(event);
        }
      });
    }

    if (event == fromStreamValidator.state) {
      streamValidator.streamSink.addError(_getErrorMessage(validationTagEnum));
    } else {
      streamValidator.streamSink.addError(ValidationEnum.validated);
      streamValidator.streamSink.add(event);
    }
  }

  void _checkForExistingValidation(ValidationTagEnum validationTagEnum) {
    for (int i = 0; i < validatorInfoList.length; ++i) {
      if (validatorInfoList[i].validationTagEnum == validationTagEnum) {
        throw Exception("validation already exists");
      }
    }
  }

  AbstractRuleBuilder matches(String expression) {
    _checkForExistingValidation(ValidationTagEnum.MATCHES);

    validatorInfoList.add(ValidatorInfo(
        abstractValidation: RegExpValue(expression: expression),
        errorMessage: "value is not matches",
        validationTagEnum: ValidationTagEnum.MATCHES));

    return this;
  }

  AbstractRuleBuilder emailAddress() {
    _checkForExistingValidation(ValidationTagEnum.EMAIL_ADDRESS);

    validatorInfoList.add(ValidatorInfo(
        abstractValidation: RegExpValue(
            expression:
                '^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})\$'),
        errorMessage: "email should be valid",
        validationTagEnum: ValidationTagEnum.EMAIL_ADDRESS));

    return this;
  }

  AbstractRuleBuilder shouldBeNumber() {
    _checkForExistingValidation(ValidationTagEnum.SHOULD_BE_NUMBER);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value is Number",
        abstractValidation: RegExpValue(expression: r'^[0-9]+$'),
        validationTagEnum: ValidationTagEnum.SHOULD_BE_NUMBER));
    return this;
  }

  AbstractRuleBuilder between(int from, int to) {
    _checkForExistingValidation(ValidationTagEnum.BETWEEN);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should be between ${from} and ${to}",
        abstractValidation: BetweenNumberValidation(from: from, to: to),
        validationTagEnum: ValidationTagEnum.BETWEEN));
    return this;
  }

  AbstractRuleBuilder isNotEmpty() {
    _checkForExistingValidation(ValidationTagEnum.NOT_EMPTY);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should not be empty",
        abstractValidation: RegExpValue(expression: '^\\w{1,1}\$'),
        validationTagEnum: ValidationTagEnum.NOT_EMPTY));
    return this;
  }

  AbstractRuleBuilder isEmpty() {
    _checkForExistingValidation(ValidationTagEnum.EMPTY);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should  be empty",
        abstractValidation: RegExpValue(expression: '^\\w{0,0}\$'),
        validationTagEnum: ValidationTagEnum.EMPTY));

    return this;
  }

  AbstractRuleBuilder
      notEqualTo<TProperty extends StreamValidator, T extends Object>(
          TProperty Function(AbstractValidator<T>) expression) {
    _checkForExistingValidation(ValidationTagEnum.NOT_EQUAL);

    var fromStreamValidator =
        expression(abstractValidator as AbstractValidator<T>);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should not be Equal",
        abstractValidation:
            CompareToValidation(streamValidator: fromStreamValidator),
        validationTagEnum: ValidationTagEnum.NOT_EQUAL));

    return this;
  }

  AbstractRuleBuilder
      equalTo<TProperty extends StreamValidator, T extends Object>(
          TProperty Function(AbstractValidator<T>) expression) {
    _checkForExistingValidation(ValidationTagEnum.EQUAL);

    var fromStreamValidator =
        expression(abstractValidator as AbstractValidator<T>);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should be Equal",
        abstractValidation:
            CompareToValidation(streamValidator: fromStreamValidator),
        validationTagEnum: ValidationTagEnum.EQUAL));

    return this;
  }

  AbstractRuleBuilder must<TProperty extends StreamValidator, T extends Object>(
      bool Function(Object) expression) {
    _checkForExistingValidation(ValidationTagEnum.MUST);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "invalid",
        abstractValidation: MustValidation(expression: expression),
        validationTagEnum: ValidationTagEnum.MUST));

    return this;
  }

  AbstractRuleBuilder withMessage(Object errorMessage) {
    if (validatorInfoList.isEmpty) {
      throw Exception("should add rule before with message");
    }

    validatorInfoList[validatorInfoList.length - 1] = ValidatorInfo(
        abstractValidation:
            validatorInfoList[validatorInfoList.length - 1].abstractValidation,
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
}
