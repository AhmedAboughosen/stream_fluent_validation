import 'package:stream_fluent_validation/model/stream_validator.dart';

import '../model/validator_info.dart';
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
