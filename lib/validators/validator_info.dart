import 'package:stream_fluent_validation/validators/abstract_validators.dart';

import '../enum/validation_enum.dart';

class ValidatorInfo {
  final ValidationTagEnum validationTagEnum;
  final Object? errorMessage;
  final AbstractValidators abstractValidation;

  ValidatorInfo({required this.abstractValidation,required this.validationTagEnum, this.errorMessage});
}
