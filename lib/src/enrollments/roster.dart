library plato.cap.enrollments.roster;

import 'package:plato.cap/src/enrollments/enrollment.dart';

/// The [Roster] class...
class Roster {
  final String courseId;

  final List<RosterEnrollment> enrollments;

  /// The [Roster] constructor...
  Roster (this.courseId, this.enrollments);
}
