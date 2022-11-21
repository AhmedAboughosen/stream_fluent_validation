
import 'package:stream_fluent_validation/validators/abstract_validators.dart';

class MustValidation extends AbstractValidators{
  final bool Function(Object) expression;

  MustValidation({required this.expression});

  @override
  bool validate(Object value) {
    return expression(value);
  }
}
