import 'package:fluent_validation/model/stream_validator.dart';

import '../enum/validation_enum.dart';
import 'abstract_validation.dart';


class CompareToConstValueValidation<TProperty extends StreamValidator,
    T extends Object> extends AbstractValidation {
  final Object newValue;
  final ValidationTagEnum validationTagEnum;

  CompareToConstValueValidation({required this.newValue,required this.validationTagEnum});

  @override
  bool validate(Object value) {
    return validationTagEnum == ValidationTagEnum.CONST_EQUAL ? value == newValue :  value != newValue;
  }
}
