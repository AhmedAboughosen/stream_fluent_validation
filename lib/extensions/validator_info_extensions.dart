
import 'package:fluent_validation/enum/validation_enum.dart';
import 'package:fluent_validation/model/validator_info.dart';

extension ValidatorInfoExtensions on ValidatorInfo {
  ValidatorInfo copyWith(
      {Object? newErrorMessage, ValidationTagEnum? newValidationTagEnum}) {
    return ValidatorInfo(
        errorMessage: newErrorMessage ?? errorMessage,
        validationTagEnum: newValidationTagEnum ?? validationTagEnum);
  }
}
