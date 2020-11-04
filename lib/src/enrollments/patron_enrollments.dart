library plato.cap.enrollments.patron;

import 'package:plato.cap/src/enrollments/enrollment.dart';
import 'package:plato.cap/src/enrollments/improper_enrollment.dart';
import 'package:plato.cap/src/users/patron/patron_user.dart';

/// The [PatronEnrollments] class...
class PatronEnrollments {
  final PatronUser patronUser;

  List<PatronEnrollment> _enrollments;

  List<PatronEnrollment> get enrollments =>
    List<PatronEnrollment>.from (_enrollments);

  PatronEnrollment selectedEnrollment;

  /// The [PatronEnrollments] constructor...
  PatronEnrollments (this.patronUser, List<PatronEnrollment> enrollments) {
    if (!_checkEnrollmentsForPatron()) {
      throw ImproperEnrollment (
        'One or more of the enrollments users does not match the patron.'
      );
    }

    enrollments.removeWhere ((enrollment) => !enrollment.courseId.contains ('cap'));

    _enrollments = enrollments;
  }

  /// The [_checkEnrollmentsForPatron] method...
  bool _checkEnrollmentsForPatron() => _enrollments.every (
    (Enrollment enrollment) => enrollment.userId == patronUser.userId
  );
}
