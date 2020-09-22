library plato.cap.enrollments.patron;

import 'package:plato.cap/src/enrollments/enrollment.dart';
import 'package:plato.cap/src/enrollments/improper_enrollment.dart';
import 'package:plato.cap/src/users/patron/patron_user.dart';

/// The [PatronEnrollments] class...
class PatronEnrollments {
  final PatronUser patronUser;

  final List<Enrollment> enrollments;

  /// The [PatronEnrollments] constructor...
  PatronEnrollments (this.patronUser, this.enrollments) {
    if (!_checkEnrollmentsForPatron()) {
      throw ImproperEnrollment (
        'One or more of the enrollments users does not match the patron.'
      );
    }
  }

  /// The [_checkEnrollmentsForPatron] method...
  bool _checkEnrollmentsForPatron() => enrollments.every (
    (Enrollment enrollment) => enrollment.userId == patronUser.userId
  );
}
