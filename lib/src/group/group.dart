library plato.cap.group;

import 'package:plato.cap/src/users/submission_user/submission_user.dart';

/// The [Group] class...
class Group {
  final String id;

  final String externalId;

  final String groupSetId;

  final String name;

  final String description;

  final String uuid;

  List<SubmissionUser> _members;

  /// The [Group] constructor...
  Group (
    this.id, this.externalId, this.groupSetId, this.name, this.description,
    this.uuid
  ) {
    _members = <SubmissionUser>[];
  }

  /// The [getMembers] function...
  List<SubmissionUser> getMembers() {
    return List.from (_members);
  }
}
