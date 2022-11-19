import 'abstract_validation.dart';

class RegExpValue extends AbstractValidation {
  final String expression;

  RegExpValue({required this.expression});

  @override
  bool validate(Object value) {
    return RegExp(expression).hasMatch("$value");
  }
}
