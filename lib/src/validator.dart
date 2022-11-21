/// <summary>
/// Base class for object validators.
/// </summary>
/// <typeparam name="T">The type of the object being validated</typeparam>
///
abstract class IValidator<T extends Object> {
  /// <summary>Validates the specified instance.</summary>
  /// <param name="instance">The instance to validate</param>
  /// <returns>A ValidationResult object containing any validation failures.</returns>
  bool validate();
}
