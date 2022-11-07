/// <summary>Defines a validator for a particular type.</summary>
/// <typeparam name="T"></typeparam>
abstract class IValidator<T extends Object> {
  /// <summary>Validates the specified instance.</summary>
  /// <param name="instance">The instance to validate</param>
  /// <returns>A ValidationResult object containing any validation failures.</returns>
  bool validate();
}
