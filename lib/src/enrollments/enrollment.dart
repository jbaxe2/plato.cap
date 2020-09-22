library plato.cap.enrollment;

/// The [Enrollment] abstract class...
abstract class Enrollment {
  final String courseId;

  final String userId;

  final String role;

  /// The [Enrollment] constructor...
  Enrollment (this.courseId, this.userId, this.role);
}
