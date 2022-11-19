import 'package:fluent_validation/model/stream_validator.dart';

import '../enum/validation_enum.dart';
import '../validator.dart';
import 'abstract_rule_builder.dart';
import 'package:fluent_validation/extensions/default_validator_extensions.dart';
abstract class AbstractValidator<T extends Object> extends IValidator<T> {
  final List<AbstractRuleBuilder> _rules = [];

  @override
  bool validate() {
    for (var i = 0; i < _rules.length; ++i) {
      if (_rules[i].streamValidator.error != ValidationEnum.validated) {
        return false;
      }
    }

    return true;
  }

  /// <summary>
  /// Defines a validation rule for a specify property.
  /// </summary>
  /// <example>
  /// RuleFor(x => x.name)...
  /// Property should extends Stream Validator
  AbstractRuleBuilder ruleFor<TProperty extends StreamValidator>(
      TProperty Function(AbstractValidator<T>) expression) {
    var streamValidator = expression(this);

    _addRule(streamValidator);

    _rules[_rules.length - 1].observe();

    return _rules[_rules.length - 1];
  }

  void _addRule<TProperty extends StreamValidator>(TProperty property) {
    _rules.add(AbstractRuleBuilder<T>(
      streamValidator: property,
      validatorInfoList: [],
      abstractValidator: this,
    ));
  }
}
