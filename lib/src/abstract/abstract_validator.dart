import 'package:stream_fluent_validation/fluent_validation.dart';

/// <summary>
/// Base class for object validators.
/// </summary>
/// <typeparam name="T">The type of the object being validated</typeparam>
///
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

  @override
  void close() {
    for (var i = 0; i < _rules.length; ++i) {
      _rules[i].streamValidator.onClose();
    }

  }

  /// <summary>Defines a validation rule for a specify property.</summary>
  /// <example>RuleFor(x =&gt; x.Surname)...</example>
  /// <typeparam name="TProperty">The type of property being validated</typeparam>
  /// <param name="expression">The expression representing the property to validate</param>
  /// <returns>an AbstractRuleBuilder instance on which validators can be defined</returns>
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
