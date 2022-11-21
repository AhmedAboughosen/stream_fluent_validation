

import 'package:stream_fluent_validation/fluent_validation.dart';


class CompareToConstValueValidation<TProperty extends StreamValidator,
    T extends Object> extends AbstractValidators {
  final Object newValue;
  final ValidationTagEnum validationTagEnum;

  CompareToConstValueValidation({required this.newValue,required this.validationTagEnum});

  @override
  bool validate(Object value) {
    return validationTagEnum == ValidationTagEnum.CONST_EQUAL ? value == newValue :  value != newValue;
  }
}
