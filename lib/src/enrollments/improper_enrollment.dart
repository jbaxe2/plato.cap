library plato.cap.improper.enrollment;

import 'package:plato.cap/src/_application/error/plato_exception.dart';

/// The [ImproperEnrollment] class...
class ImproperEnrollment extends PlatoException {
  /// The [ImproperEnrollment] constructor...
  ImproperEnrollment (
    [message = 'Encountered a generalized improper enrollment.']
  ) : super (message);
}
