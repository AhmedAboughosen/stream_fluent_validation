import 'abstract_validators.dart';

class BetweenNumberValidation extends AbstractValidators {
  final int from;
  final int to;

  BetweenNumberValidation({required this.from,required this.to});

  @override
  bool validate(Object value) {
    String state = value.toString();

    return (state.length >= from && state.length <= to);
  }
}
