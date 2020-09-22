library plato.cap.users.patron;

import 'package:plato.cap/src/users/user.dart';

/// The [PatronUser] class...
class PatronUser extends User {
  /// The [PatronUser] constructor...
  PatronUser (String firstName, String lastName, String userId) :
    super (firstName, lastName, userId);
}
