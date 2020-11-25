library plato.cap.factories.user.submission;

import 'package:plato.cap/src/users/submission_user/improper_submission_user.dart';
import 'package:plato.cap/src/users/submission_user/submission_user.dart';

/// The [SubmissionUserFactory] abstract class...
abstract class SubmissionUserFactory {
  /// The [createAll] static method...
  static List<SubmissionUser> createAll (List<Map<String, String>> rawUsers) {
    var submissionUsers = <SubmissionUser>[];

    rawUsers.forEach ((rawUser) => submissionUsers.add (create (rawUser)));

    return submissionUsers;
  }

  /// The [create] static method...
  static SubmissionUser create (Map<String, String> rawUser) {
    if (!_checkUserInfo (rawUser)) {
      throw ImproperSubmissionUser ('Invalid info to create the submission user.');
    }

    return SubmissionUser (
      rawUser['learn.user.firstName'], rawUser['learn.user.lastName'],
      rawUser['banner.user.cwid'], rawUser['learn.user.username'],
      rawUser['learn.user.id']);
  }

  /// The [_checkUserInfo] private static method...
  static bool _checkUserInfo (Map<String, String> rawUser) {
    return rawUser.containsKey ('banner.user.cwid') &&
      rawUser.containsKey ('learn.user.id') &&
      rawUser.containsKey ('learn.user.username') &&
      rawUser.containsKey ('learn.user.firstName') &&
      rawUser.containsKey ('learn.user.lastName');
  }
}
