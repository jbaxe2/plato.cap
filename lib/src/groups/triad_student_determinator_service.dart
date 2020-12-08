library plato.cap.services.determinator.triad_students;

import 'package:plato.cap/src/enrollments/roster.dart';
import 'package:plato.cap/src/groups/group.dart';

/// The [TriadStudentDeterminatorService] class...
class TriadStudentDeterminatorService {
  Map<String, List<String>> _courseTriadStudents;

  static TriadStudentDeterminatorService _instance;

  /// The [TriadStudentDeterminatorService] factory constructor...
  factory TriadStudentDeterminatorService() =>
    _instance ?? (_instance = TriadStudentDeterminatorService._());

  /// The [TriadStudentDeterminatorService] private named constructor...
  TriadStudentDeterminatorService._() {
    _courseTriadStudents = <String, List<String>>{};
  }

  /// The [determineTriadStudents] method...
  List<String> determineTriadStudents (
    Roster roster, List<Group> groupSets, List<Group> groups
  ) {
    var filteredGroupSets = _filterTriadGroupSets (groupSets);
    var filteredGroups = _filterGroupsForTriads (filteredGroupSets, groups);

    return _courseTriadStudents[roster.courseId] =
      _extractTriadStudents (roster, filteredGroups);
  }

  /// The [haveTriadStudentsForCourse] method...
  bool haveTriadStudentsForCourse (String courseId) =>
    _courseTriadStudents.containsKey (courseId);

  /// The [getTriadStudentsForCourse] method...
  List<String> getTriadStudentsForCourse (String courseId) =>
    _courseTriadStudents[courseId];

  /// The [_filterTriadGroupSets] private method...
  List<Group> _filterTriadGroupSets (List<Group> groupSets) {
    groupSets.retainWhere (
      (groupSet) =>
        (groupSet.name.toLowerCase().contains ('triad') ||
         groupSet.name.toLowerCase().contains ('quad'))
    );

    return groupSets;
  }

  /// The [_filterGroupsForTriads] private method...
  List<Group> _filterGroupsForTriads (List<Group> groupSets, List<Group> groups) {
    groups.retainWhere (
      (group) =>
        groupSets.any ((groupSet) => group.groupSetId == groupSet.id)
    );

    return groups;
  }

  /// The [_extractTriadStudents] private method...
  List<String> _extractTriadStudents (Roster roster, List<Group> groups) {
    var triadStudents = <String>[];

    groups.forEach ((group) {
      var rosterEnrollment = roster.enrollments.firstWhere ((enrollment) {
        var submissionUser = enrollment.submissionUser;

        return group.name.toLowerCase().contains (submissionUser.firstName) &&
          group.name.toLowerCase().contains (submissionUser.lastName);
      }, orElse: () => null);

      if (null != rosterEnrollment) {
        triadStudents.add (rosterEnrollment.submissionUser.blackboardId);;
      }
    });

    return triadStudents;
  }
}
