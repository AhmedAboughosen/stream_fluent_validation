import 'abstract_validation.dart';

class MustValidation extends AbstractValidation{
  final bool Function(Object) expression;

  MustValidation({required this.expression});

  @override
  bool validate(Object value) {
    return expression(value);
  }
}
