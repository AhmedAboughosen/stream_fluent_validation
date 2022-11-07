import '../enum/validation_enum.dart';

class ValidatorInfo {
  final ValidationTagEnum validationTagEnum;
  final Object? errorMessage;

  ValidatorInfo({required this.validationTagEnum, this.errorMessage});
}
