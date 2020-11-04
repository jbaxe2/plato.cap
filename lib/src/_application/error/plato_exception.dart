library plato.crf.exceptions.plato;

import 'package:plato.cap/src/_application/error/error_service.dart';

/// The [PlatoException] abstract class...
abstract class PlatoException implements Exception {
  final String message;

  /// The [PlatoException] constructor...
  PlatoException (
    [this.message = 'A Plato exception has occurred; details have not been specified.']
  ) {
    (ErrorService()).raiseError (this);
  }

  /// The [toString] method...
  @override
  String toString() => message;
}
