import '../enum/validation_enum.dart';
import 'abstract_validation.dart';

class ValidatorInfo {
  final ValidationTagEnum validationTagEnum;
  final Object? errorMessage;
  final AbstractValidation abstractValidation;

  ValidatorInfo({required this.abstractValidation,required this.validationTagEnum, this.errorMessage});
}
