import 'package:stream_fluent_validation/fluent_validation.dart';


class ValidatorInfo {
  final ValidationTagEnum validationTagEnum;
  final Object? errorMessage;
  final AbstractValidators abstractValidation;

  ValidatorInfo({required this.abstractValidation,required this.validationTagEnum, this.errorMessage});
}
