library plato.cap.enrollment;

/// The [Enrollment] abstract class...
abstract class Enrollment {
  final String courseId;

  final String userId;

  final String role;

  final bool available;

  /// The [Enrollment] constructor...
  Enrollment (this.courseId, this.userId, this.role, this.available);
}
