library plato.cap.improper.form.cap;

import 'package:plato.cap/src/_application/error/plato_exception.dart';

/// The [ImproperCapForm] class...
class ImproperCapForm extends PlatoException {
  /// The [ImproperCapForm] constructor...
  ImproperCapForm (
    [message = 'Encountered generalized improper cap form data.']
  ) : super (message);
}
