library plato.cap.services.groups;

import 'package:http/http.dart' show Client;

import 'package:plato.cap/src/_application/_utility/functions.dart';
import 'package:plato.cap/src/groups/group.dart';
import 'package:plato.cap/src/groups/groups_factory.dart';
import 'package:plato.cap/src/groups/improper_group.dart';

const String _GROUPS_URI = '/plato/retrieve/groups';

/// The [GroupsService] class...
class GroupsService {
  Map<String, List<Group>> _groups;

  Map<String, List<Group>> _groupSets;

  Map<Group, List<String>> _groupMembers;

  final Client _http;

  static GroupsService _instance;

  /// The [GroupsService] factory constructor...
  factory GroupsService (Client http) => _instance ?? GroupsService._ (http);

  /// The [GroupsService] private constructor...
  GroupsService._ (this._http) {
    _groups = <String, List<Group>>{};
    _groupSets = <String, List<Group>>{};
    _groupMembers = <Group, List<String>>{};
  }

  /// The [loadGroupsForCourse] method...
  Future<void> loadGroupsForCourse (String courseId) async {
    try {
      var response = await _http.get ('$_GROUPS_URI?course=$courseId');

      var rawResponse = decodeResponse (response) as Map<String, dynamic>;

      _extractGroups (courseId, rawResponse['groups']);
      _extractGroupSets (courseId, rawResponse['groupSets']);
      _extractGroupMemberships (courseId, rawResponse['groupMemberships']);
    } catch (_) {
      throw ImproperGroup ('Unable to retrieve the groups for the course.');
    }
  }

  /// The [getGroupsForCourse] method...
  List<Group> getGroupsForCourse (String courseId) =>
    List<Group>.from (_groups[courseId]);

  /// The [getGroupSetsForCourse] method...
  List<Group> getGroupSetsForCourse (String courseId) =>
    List<Group>.from (_groupSets[courseId]);

  /// The [getGroupMemberships] method...
  List<String> getGroupMemberships (String groupId) {
    var memberedGroup = _groupMembers.keys.firstWhere (
      (Group group) => group.id == groupId, orElse: () => null
    );

    return _groupMembers[memberedGroup] ?? [];
  }

  /// The [haveGroupsForCourse] method...
  bool haveGroupsForCourse (String courseId) => _groups.containsKey (courseId);

  /// The [_extractGroups] method...
  void _extractGroups (String courseId, List<Map<String, String>> rawGroups) {
    _groups[courseId] = GroupsFactory.createGroups (rawGroups);
  }

  /// The [_extractGroupSets] method...
  void _extractGroupSets (String courseId, List<Map<String, String>> rawGroupSets) {
    _groupSets[courseId] = GroupsFactory.createGroups (rawGroupSets);
  }

  /// The [_extractGroupMemberships] method...
  void _extractGroupMemberships (
    String courseId, Map<String, List<String>> rawGroupMemberships
  ) {
    _groups[courseId].forEach ((Group group) {
      _groupMembers[group] = rawGroupMemberships[group.id];
    });
  }
}
