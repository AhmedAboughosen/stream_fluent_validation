import 'package:stream_fluent_validation/fluent_validation.dart';

class EmptyValidation extends AbstractValidators {
  final ValidationTagEnum validationTagEnum;

  EmptyValidation({required this.validationTagEnum});

  @override
  bool validate(Object value) {
    return validationTagEnum == ValidationTagEnum.NOT_EMPTY
        ? notEmptyString(value) && notEmptyCollection(value)
        : emptyString(value) && emptyCollection(value);
  }

  bool notEmptyString(Object value) {
    if (value is! String) return true;
    return (value).isNotEmpty;
  }

  bool notEmptyCollection(Object value) {
    if (value is! Iterable) return true;
    return (value).isNotEmpty;
  }

  bool emptyString(Object value) {
    if (value is! String) return true;
    return (value).isEmpty;
  }

  bool emptyCollection(Object value) {
    if (value is! Iterable) return true;
    return (value).isEmpty;
  }
}
