library plato.cap.factories.roster;

import 'package:plato.cap/src/enrollments/enrollments_factory.dart';
import 'package:plato.cap/src/enrollments/roster.dart';

/// The [RosterFactory] abstract class...
abstract class RosterFactory {
  /// The [create] static method...
  static Roster create (
    String courseId, List<Map<String, String>> rawEnrollments
  ) => Roster (courseId, EnrollmentsFactory.createForRoster (rawEnrollments));
}
