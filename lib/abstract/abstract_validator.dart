import 'package:fluent_validation/model/stream_validator.dart';

import '../enum/validation_enum.dart';
import '../fluent_validation.dart';
import '../validator.dart';
import 'abstract_rule_builder.dart';

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
    if (expression == null) {
      throw Exception("expression Function can't be null");
    }

    var streamValidator = expression(this);

    addRule(streamValidator);

    return _rules[_rules.length - 1];
  }

  StreamValidator create<TProperty extends StreamValidator>(
      TProperty Function(T) expression) {
    try {
      var instanceOfT = getIt.get<T>();

      return expression(instanceOfT);
    } catch (e) {
      throw Exception(
          'To use this library you should add get it to your objects.');
    }
  }

  void addRule<TProperty extends StreamValidator>(TProperty property) {
    _rules.add(
        AbstractRuleBuilder(streamValidator: property, validatorInfoList: []));
  }
}
