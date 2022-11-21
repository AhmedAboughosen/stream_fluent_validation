import 'package:stream_fluent_validation/abstract/abstract_rule_builder.dart';
import 'package:stream_fluent_validation/enum/validation_enum.dart';
import 'package:stream_fluent_validation/model/validator_info.dart';

import '../abstract/abstract_validator.dart';
import '../model/between_number_validation.dart';
import '../model/compare_to_validation.dart';
import '../model/compare_to_value_validation.dart';
import '../model/must_validation.dart';
import '../model/reg_rxp.dart';
import '../model/stream_validator.dart';

extension DefaultValidatorExtensions on AbstractRuleBuilder {
  ///when any change accrued on data inner stream will fire.
  ///
  void observe() {
    streamValidator.innerStream.listen(
      (event) {
        for (int i = 0; i < validatorInfoList.length; ++i) {
          ValidationTagEnum currentValidationTagEnum =
              validatorInfoList[i].validationTagEnum;

          switch (currentValidationTagEnum) {
            case ValidationTagEnum.MATCHES:
              {
                if (!_sendEventToClient(i, event, ValidationTagEnum.MATCHES))
                  return;
                break;
              }
            case ValidationTagEnum.EMAIL_ADDRESS:
              {
                if (!_sendEventToClient(
                    i, event, ValidationTagEnum.EMAIL_ADDRESS)) return;
                break;
              }
            case ValidationTagEnum.SHOULD_BE_NUMBER:
              {
                if (!_sendEventToClient(
                    i, event, ValidationTagEnum.SHOULD_BE_NUMBER)) return;
                break;
              }
            case ValidationTagEnum.BETWEEN:
              {
                if (!_sendEventToClient(i, event, ValidationTagEnum.BETWEEN))
                  return;

                break;
              }
            case ValidationTagEnum.NOT_EMPTY:
              {
                if (!_sendEventToClient(i, event, ValidationTagEnum.NOT_EMPTY))
                  return;

                break;
              }
            case ValidationTagEnum.EMPTY:
              {
                if (!_sendEventToClient(i, event, ValidationTagEnum.EMPTY))
                  return;

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
                if (!_sendEventToClient(i, event, ValidationTagEnum.MUST))
                  return;

                break;
              }
            case ValidationTagEnum.CONST_EQUAL:
              {
                if (!_sendEventToClient(
                    i, event, ValidationTagEnum.CONST_EQUAL)) return;

                break;
              }
            case ValidationTagEnum.CONST_NOT_EQUAL:
              {
                if (!_sendEventToClient(
                    i, event, ValidationTagEnum.CONST_NOT_EQUAL)) return;

                break;
              }
          }
        }
      },
    );
  }

  bool _sendEventToClient(
      int index, Object event, ValidationTagEnum validationTagEnum) {
    var isValidated =
        validatorInfoList[index].abstractValidation.validate(event);
    if (!isValidated) {
      streamValidator.streamSink.addError(_getErrorMessage(validationTagEnum));
    } else {
      streamValidator.streamSink.addError(ValidationEnum.validated);
      streamValidator.streamSink.add(event);
    }

    return isValidated;
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

    fromStreamValidator.innerStream.listen((event) {
      if (streamValidator.stateOfInnerStream == event) {
        streamValidator.streamSink
            .addError(_getErrorMessage(validationTagEnum));
      } else {
        streamValidator.streamSink.addError(ValidationEnum.validated);
        streamValidator.streamSink.add(event);
      }
    });

    if (event == fromStreamValidator.stateOfInnerStream) {
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

  /// <summary>
  /// Defines a regular expression validator on the current rule builder, but only for string properties.
  /// Validation will fail if the value returned by the lambda does not match the regular expression.
  /// </summary>
  /// <param name="expression">The regular expression to check the value against.</param>
  AbstractRuleBuilder matches(String expression) {
    _checkForExistingValidation(ValidationTagEnum.MATCHES);

    validatorInfoList.add(ValidatorInfo(
        abstractValidation: RegExpValue(expression: expression),
        errorMessage: "value is not matches",
        validationTagEnum: ValidationTagEnum.MATCHES));

    return this;
  }

  /// <summary>
  /// Defines an email validator on the current rule builder for string properties.
  /// Validation will fail if the value returned by the lambda is not a valid email address.
  /// </summary>
  /// <typeparam name="T">Type of object being validated</typeparam>
  /// <returns></returns>
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

  /// <summary>
  /// Defines an Number validator on the current rule builder for string properties.
  /// Validation will fail if the value returned by the lambda is not a Number.
  /// </summary>
  /// <typeparam name="T">Type of object being validated</typeparam>
  /// <returns></returns>
  AbstractRuleBuilder shouldBeNumber() {
    _checkForExistingValidation(ValidationTagEnum.SHOULD_BE_NUMBER);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value is Number",
        abstractValidation: RegExpValue(expression: r'^[0-9]+$'),
        validationTagEnum: ValidationTagEnum.SHOULD_BE_NUMBER));
    return this;
  }

  /// <summary>
  /// Defines a length validator on the current rule builder, but only for string properties.
  /// Validation will fail if the length of the string is not equal to the length specified.
  /// </summary>
  /// <typeparam name="T">Type of object being validated</typeparam>
  /// <returns></returns>
  AbstractRuleBuilder length(int from, int to) {
    _checkForExistingValidation(ValidationTagEnum.BETWEEN);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should be between ${from} and ${to}",
        abstractValidation: BetweenNumberValidation(from: from, to: to),
        validationTagEnum: ValidationTagEnum.BETWEEN));
    return this;
  }

  /// <summary>
  /// Defines a 'not empty' validator on the current rule builder.
  /// Validation will fail if the property is null, an empty string, whitespace, an empty collection or the default value for the type (for example, 0 for integers but null for nullable integers)
  /// </summary>
  /// <typeparam name="T">Type of object being validated</typeparam>
  /// <returns></returns>
  AbstractRuleBuilder notEmpty() {
    _checkForExistingValidation(ValidationTagEnum.NOT_EMPTY);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should not be empty",
        abstractValidation: RegExpValue(expression: '^\\w{1,1}\$'),
        validationTagEnum: ValidationTagEnum.NOT_EMPTY));
    return this;
  }

  /// <summary>
  /// Defines a 'empty' validator on the current rule builder.
  /// Validation will fail if the property is not null, an empty or the default value for the type (for example, 0 for integers)
  /// </summary>
  /// <typeparam name="T">Type of object being validated</typeparam>
  /// <returns></returns>
  AbstractRuleBuilder empty() {
    _checkForExistingValidation(ValidationTagEnum.EMPTY);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should  be empty",
        abstractValidation: RegExpValue(expression: '^\\w{0,0}\$'),
        validationTagEnum: ValidationTagEnum.EMPTY));

    return this;
  }

  /// <summary>
  /// Defines a 'not equal' validator on the current rule builder.
  /// Validation will fail if the specified value is equal to the value of the property.
  /// For strings, this performs an ordinal comparison unless you specify a different comparer.
  /// </summary>
  /// <typeparam name="T">Type of object being validated</typeparam>
  /// <typeparam name="TProperty">Type of property being validated</typeparam>
  /// <returns></returns>
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

  /// <summary>
  /// Defines an 'equals' validator on the current rule builder.
  /// Validation will fail if the specified value is not equal to the value of the property.
  /// For strings, this performs an ordinal comparison unless you specify a different comparer.
  /// </summary>
  /// <typeparam name="T">Type of object being validated</typeparam>
  /// <typeparam name="TProperty">Type of property being validated</typeparam>
  /// <returns></returns>
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

  /// <summary>
  /// Defines an 'equals Const Value' validator on the current rule builder.
  /// Validation will fail if the specified value is not equal to the value of the property.
  /// For strings, this performs an ordinal comparison unless you specify a different comparer.
  /// </summary>
  /// <typeparam name="T">Type of object being validated</typeparam>
  /// <typeparam name="TProperty">Type of property being validated</typeparam>
  /// <returns></returns>
  AbstractRuleBuilder
      equalToConstValue<TProperty extends StreamValidator, T extends Object>(
          Object value) {
    _checkForExistingValidation(ValidationTagEnum.CONST_EQUAL);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should be Equal",
        abstractValidation: CompareToConstValueValidation(
            newValue: value, validationTagEnum: ValidationTagEnum.CONST_EQUAL),
        validationTagEnum: ValidationTagEnum.CONST_EQUAL));

    return this;
  }

  /// <summary>
  /// Defines a 'not equal Const Value' validator on the current rule builder.
  /// Validation will fail if the specified value is equal to the value of the property.
  /// For strings, this performs an ordinal comparison unless you specify a different comparer.
  /// </summary>
  /// <typeparam name="T">Type of object being validated</typeparam>
  /// <typeparam name="TProperty">Type of property being validated</typeparam>
  /// <returns></returns>
  AbstractRuleBuilder
      notEqualToConstValue<TProperty extends StreamValidator, T extends Object>(
          Object value) {
    _checkForExistingValidation(ValidationTagEnum.CONST_NOT_EQUAL);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "value should not be  Equal",
        abstractValidation: CompareToConstValueValidation(
            newValue: value,
            validationTagEnum: ValidationTagEnum.CONST_NOT_EQUAL),
        validationTagEnum: ValidationTagEnum.CONST_NOT_EQUAL));

    return this;
  }

  /// <summary>
  /// Defines a predicate validator on the current rule builder using a lambda expression to specify the predicate.
  /// Validation will fail if the specified lambda returns false.
  /// Validation will succeed if the specified lambda returns true.
  /// </summary>
  /// <typeparam name="T">Type of object being validated</typeparam>
  /// <typeparam name="TProperty">Type of property being validated</typeparam>
  /// <returns></returns>
  AbstractRuleBuilder must<TProperty extends StreamValidator, T extends Object>(
      bool Function(Object) expression) {
    _checkForExistingValidation(ValidationTagEnum.MUST);

    validatorInfoList.add(ValidatorInfo(
        errorMessage: "invalid",
        abstractValidation: MustValidation(expression: expression),
        validationTagEnum: ValidationTagEnum.MUST));

    return this;
  }

  /// <summary>
  /// Specifies a custom error message to use when validation fails. Only applies to the rule that directly precedes it.
  /// </summary>
  /// <param name="rule">The current rule</param>
  /// <param name="errorMessage">The error message to use</param>
  /// <returns></returns>
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
