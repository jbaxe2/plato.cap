library plato.cap.services.groups;

import 'package:http/http.dart' show Client;

import 'package:plato.cap/src/group/group.dart';

const String _GROUPS_URI = '/plato/retrieve/groups';

/// The [GroupsService] class...
class GroupsService {
  Map<String, List<Group>> _groups;

  final Client _http;

  static GroupsService _instance;

  /// The [GroupsService] factory constructor...
  factory GroupsService (Client http) => _instance ?? GroupsService._ (http);

  /// The [GroupsService] private constructor...
  GroupsService._ (this._http);

  /// The [loadGroupsForCourse] method...
  Future<void> loadGroupsForCourse (String courseId) async {
    ;
  }
}
