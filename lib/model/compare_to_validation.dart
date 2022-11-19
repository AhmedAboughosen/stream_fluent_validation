import 'package:fluent_validation/model/stream_validator.dart';

import '../abstract/abstract_validator.dart';
import 'abstract_validation.dart';

class CompareToValidation<TProperty extends StreamValidator, T extends Object>
    extends AbstractValidation {

  final StreamValidator streamValidator;

  CompareToValidation({required this.streamValidator});

  @override
  bool validate(Object value) {
    return false;
  }
}
