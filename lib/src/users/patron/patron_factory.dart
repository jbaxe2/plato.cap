library plato.cap.factories.user.patron;

import 'package:plato.cap/src/users/patron/improper_patron.dart';
import 'package:plato.cap/src/users/patron/patron_user.dart';

/// The [PatronFactory] class...
abstract class PatronFactory {
  /// The [create] method...
  static PatronUser create (Map<String, String> rawPatron) {
    if (rawPatron.containsKey ('learn.user.username') &&
        rawPatron.containsKey ('learn.user.firstName') &&
        rawPatron.containsKey ('learn.user.lastName') &&
        rawPatron.containsKey ('learn.user.email') &&
        rawPatron.containsKey ('banner.user.cwid')) {
      throw ImproperPatron ('Invalid info to create the patron.');
    }

    return PatronUser (
      rawPatron['learn.user.firstName'], rawPatron['learn.user.lastName'],
      rawPatron['learn.user.username']
    );
  }
}
