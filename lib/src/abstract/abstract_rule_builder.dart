
import 'package:stream_fluent_validation/fluent_validation.dart';

class AbstractRuleBuilder<T extends Object> {
  final StreamValidator streamValidator;
  final List<ValidatorInfo> validatorInfoList;
  final AbstractValidator<T> abstractValidator;

  AbstractRuleBuilder(
      {required this.validatorInfoList,
      required this.streamValidator,
      required this.abstractValidator});
}
