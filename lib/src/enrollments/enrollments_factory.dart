library plato.cap.factories.enrollments;

import 'package:plato.cap/src/enrollments/enrollment.dart';
import 'package:plato.cap/src/enrollments/improper_enrollment.dart';

/// The [EnrollmentsFactory] class...
abstract class EnrollmentsFactory {
  /// The [createForPatron] static method...
  static List<PatronEnrollment> createForPatron (
    List<Map<String, String>> rawEnrollments
  ) {
    var enrollments = <PatronEnrollment>[];

    rawEnrollments.forEach ((rawEnrollment) => enrollments.add (
      EnrollmentsFactory.createPatronEnrollment (rawEnrollment)
    ));

    return enrollments;
  }

  /// The [createPatronEnrollment] static method...
  static PatronEnrollment createPatronEnrollment (Map<String, String> rawEnrollment) {
    if (!EnrollmentsFactory._checkRawEnrollmentInfo (rawEnrollment)) {
      throw ImproperEnrollment ('Invalid info to create the patron enrollment.');
    }

    return PatronEnrollment (
      rawEnrollment['learn.course.id'], rawEnrollment['banner.user.cwid'],
      ('true' == rawEnrollment['learn.membership.available'])
    );
  }

  /// The [createForRoster] static method...
  static List<RosterEnrollment> createForRoster (
    List<Map<String, String>> rawEnrollments
  ) {
    var enrollments = <RosterEnrollment>[];

    rawEnrollments.forEach ((rawEnrollment) => enrollments.add (
      EnrollmentsFactory.createRosterEnrollment (rawEnrollment)
    ));

    return enrollments;
  }

  /// The [createRosterEnrollment] method...
  static RosterEnrollment createRosterEnrollment (
    Map<String, String> rawEnrollment
  ) {
    if (!EnrollmentsFactory._checkRawEnrollmentInfo (rawEnrollment)) {
      throw ImproperEnrollment ('Invalid info to create the roster enrollment.');
    }

    return RosterEnrollment (
      rawEnrollment['learn.course.id'], rawEnrollment['banner.user.cwid'],
      ('true' == rawEnrollment['learn.membership.available'])
    );
  }

  /// The [_checkRawEnrollmentInfo] private static method...
  static bool _checkRawEnrollmentInfo (Map<String, String> rawEnrollment) {
    return rawEnrollment.containsKey ('banner.user.cwid') &&
      rawEnrollment.containsKey ('learn.user.username') &&
      rawEnrollment.containsKey ('learn.course.id') &&
      rawEnrollment.containsKey ('learn.course.name') &&
      rawEnrollment.containsKey ('learn.membership.role') &&
      rawEnrollment.containsKey ('learn.membership.available');
  }
}
