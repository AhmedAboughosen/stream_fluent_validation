import 'package:fluent_validation/model/stream_validator.dart';

import '../model/validator_info.dart';

class AbstractRuleBuilder{
  final StreamValidator streamValidator;
  final List<ValidatorInfo> validatorInfoList;

  AbstractRuleBuilder({required this.streamValidator,required this.validatorInfoList});
}