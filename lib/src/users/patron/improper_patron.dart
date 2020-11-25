library plato.cap.improper.user.patron;

import 'package:plato.cap/src/_application/error/plato_exception.dart';

/// The [ImproperPatron] class...
class ImproperPatron extends PlatoException {
  /// The [ImproperPatron] constructor...
  ImproperPatron (
    [message = 'Encountered a generalized improper patron.']
  ) : super (message);
}
