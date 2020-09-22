library plato.cap.submission;

import 'package:plato.cap/src/forms/cap_form.dart';

import 'package:plato.cap/src/users/submission_user/submission_user.dart';

/// The [Submission] class...
class Submission {
  final CapForm form;

  final SubmissionUser user;

  /// The [Submission] constructor...
  Submission (this.form, this.user);
}
