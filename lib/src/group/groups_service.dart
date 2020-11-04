library plato.cap.services.groups;

import 'package:http/http.dart' show Client;
import 'package:plato.cap/src/_application/_utility/functions.dart';

import 'package:plato.cap/src/group/group.dart';
import 'package:plato.cap/src/group/groups_factory.dart';
import 'package:plato.cap/src/group/improper_group.dart';

const String _GROUPS_URI = '/plato/retrieve/groups';

/// The [GroupsService] class...
class GroupsService {
  Map<String, List<Group>> _groups;

  Map<String, List<Group>> get groups => Map<String, List<Group>>.from (_groups);

  final Client _http;

  static GroupsService _instance;

  /// The [GroupsService] factory constructor...
  factory GroupsService (Client http) => _instance ?? GroupsService._ (http);

  /// The [GroupsService] private constructor...
  GroupsService._ (this._http);

  /// The [loadGroupsForCourse] method...
  Future<void> loadGroupsForCourse (String courseId) async {
    try {
      var response = _http.get (_GROUPS_URI);

      List<Map<String, String>> rawGroups =
        decodeResponse ((response as Map)['groups']);

      _groups[courseId] = GroupsFactory.createGroups (rawGroups);
    } catch (_) {
      throw ImproperGroup ('Unable to retrieve the groups for the course.');
    }
  }
}
