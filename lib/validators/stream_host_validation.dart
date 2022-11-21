
import '../abstract/abstract_validator.dart';
import 'stream_validator.dart';
import 'abstract_validators.dart';

class StreamHostValidation<TProperty extends StreamValidator, T extends Object>
    extends AbstractValidators {

  final StreamValidator streamValidator;

  StreamHostValidation({required this.streamValidator});

  @override
  bool validate(Object value) {
    return false;
  }
}
