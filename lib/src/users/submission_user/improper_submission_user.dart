library plato.cap.improper.user.submission;

import 'package:plato.cap/src/_application/error/plato_exception.dart';

/// The [ImproperSubmissionUser] class...
class ImproperSubmissionUser extends PlatoException {
  /// The [ImproperSubmissionUser] constructor...
  ImproperSubmissionUser (
    [message = 'Encountered a generalized improper submission user.']
  ) : super (message);
}
