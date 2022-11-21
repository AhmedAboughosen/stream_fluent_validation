import 'package:stream_fluent_validation/fluent_validation.dart';

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
