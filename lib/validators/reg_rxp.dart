
import 'package:stream_fluent_validation/validators/abstract_validators.dart';

class RegExpValue extends AbstractValidators {
  final String expression;

  RegExpValue({required this.expression});

  @override
  bool validate(Object value) {
    return RegExp(expression).hasMatch("$value");
  }
}
