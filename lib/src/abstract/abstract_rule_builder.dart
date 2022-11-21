
import '../validators/stream_validator.dart';
import '../validators/validator_info.dart';
import 'abstract_validator.dart';

class AbstractRuleBuilder<T extends Object> {
  final StreamValidator streamValidator;
  final List<ValidatorInfo> validatorInfoList;
  final AbstractValidator<T> abstractValidator;

  AbstractRuleBuilder(
      {required this.validatorInfoList,
      required this.streamValidator,
      required this.abstractValidator});
}
