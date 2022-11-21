
import 'package:stream_fluent_validation/fluent_validation.dart';

class RegExpValue extends AbstractValidators {
  final String expression;

  RegExpValue({required this.expression});

  @override
  bool validate(Object value) {
    return RegExp(expression).hasMatch("$value");
  }
}
