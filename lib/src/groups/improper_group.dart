library plato.cap.improper.group;

import 'package:plato.cap/src/_application/error/plato_exception.dart';

/// The [ImproperGroup] class...
class ImproperGroup extends PlatoException {
  /// The [ImproperGroup] constructor...
  ImproperGroup (
    [message = 'Encountered a generalized improper group.']
  ) : super (message);
}
