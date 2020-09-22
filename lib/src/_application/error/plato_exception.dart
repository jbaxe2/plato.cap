library plato.crf.exceptions.plato;

/// The [PlatoException] abstract class...
abstract class PlatoException implements Exception {
  final String message;

  /// The [PlatoException] constructor...
  PlatoException (
    [this.message = 'A Plato exception has occurred; details have not been specified.']
  );

  /// The [toString] method...
  @override
  String toString() => message;
}
