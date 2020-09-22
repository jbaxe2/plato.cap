library plato.cap.user;

/// The [User] abstract class...
abstract class User {
  final String firstName;

  final String lastName;

  final String userId;

  /// The [User] constructor...
  User (this.firstName, this.lastName, this.userId);
}
