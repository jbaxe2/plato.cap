library plato.cap.enrollment;

/// The [Enrollment] abstract class...
abstract class Enrollment {
  final String courseId;

  final String courseName;

  final String userId;

  final String role;

  final bool available;

  /// The [Enrollment] constructor...
  Enrollment (
    this.courseId, this.courseName, this.userId, this.role, this.available
  );
}

/// The [PatronEnrollment] class...
class PatronEnrollment extends Enrollment {
  PatronEnrollment (
    String courseId, String courseName, String userId, bool available
  ) : super (courseId, courseName, userId, 'Instructor', available);
}

/// The [RosterEnrollment] class...
class RosterEnrollment extends Enrollment {
  RosterEnrollment (
    String courseId, String courseName, String userId, bool available
  ) : super (courseId, courseName, userId, 'Student', available);
}
