
import 'package:stream_fluent_validation/fluent_validation.dart';

class StreamHostValidation<TProperty extends StreamValidator, T extends Object>
    extends AbstractValidators {

  final StreamValidator streamValidator;

  StreamHostValidation({required this.streamValidator});

  @override
  bool validate(Object value) {
    return false;
  }
}
