library plato.cap.factories.groups;

import 'package:plato.cap/src/group/group.dart';
import 'package:plato.cap/src/group/improper_group.dart';

/// The [GroupsFactory] class...
abstract class GroupsFactory {
  /// The [createGroups] static method...
  static List<Group> createGroups (List<Map<String, String>> rawGroups) {
    var groups = <Group>[];

    rawGroups.forEach (
      (rawGroup) => groups.add (GroupsFactory.createGroup (rawGroup))
    );

    return groups;
  }

  /// The [createGroup] static method...
  static Group createGroup (Map<String, String> rawGroup) {
    if (GroupsFactory._checkGroupInfo (rawGroup)) {
      throw ImproperGroup ('Invalid info to create the group.');
    }

    return Group (
      rawGroup['learn.group.id'], rawGroup['learn.group.externalId'],
      rawGroup['learn.group.groupSetId'], rawGroup['learn.group.name'],
      rawGroup['learn.group.description'], rawGroup['learn.group.uuid'],
    );
  }

  /// The [_checkGroupInfo] static private method...
  static bool _checkGroupInfo (Map<String, String> rawGroup) {
    return rawGroup.containsKey ('learn.group.id') &&
      rawGroup.containsKey ('learn.group.externalId') &&
      rawGroup.containsKey ('learn.group.groupSetId') &&
      rawGroup.containsKey ('learn.group.name') &&
      rawGroup.containsKey ('learn.group.description') &&
      rawGroup.containsKey ('learn.group.uuid');
  }
}
