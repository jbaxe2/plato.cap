library plato.cap.improper.roster;

import 'package:plato.cap/src/_application/error/plato_exception.dart';

/// The [ImproperRoster] class...
class ImproperRoster extends PlatoException {
  /// The [ImproperRoster] constructor...
  ImproperRoster (
    [message = 'Encountered a generalized improper roster.']
  ) : super (message);
}
