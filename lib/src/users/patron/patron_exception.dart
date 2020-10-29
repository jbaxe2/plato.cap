library plato.cap.exceptions.patron;

import 'package:plato.cap/src/_application/error/plato_exception.dart';

/// The [PatronException] class...
class PatronException extends PlatoException {
  /// The [PatronException] constructor...
  PatronException (
    [message = 'An unknown generalized patron exception has occurred.']
  ) : super (message);
}
