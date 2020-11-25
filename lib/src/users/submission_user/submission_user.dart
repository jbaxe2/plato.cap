library plato.cap.users.submission;

import 'package:plato.cap/src/users/user.dart';

/// The [SubmissionUser] class...
class SubmissionUser extends User {
  final String userName;

  final String blackboardId;

  /// The [SubmissionUser] constructor...
  SubmissionUser (
    String firstName, String lastName, String userId,
    this.userName, this.blackboardId
  ) : super (firstName, lastName, userId);
}
