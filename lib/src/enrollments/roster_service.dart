library plato.cap.services.roster;

import 'package:http/http.dart' show Client;

import 'package:plato.cap/src/_application/_utility/functions.dart';
import 'package:plato.cap/src/enrollments/improper_roster.dart';
import 'package:plato.cap/src/enrollments/roster.dart';
import 'package:plato.cap/src/enrollments/roster_factory.dart';

const String _ROSTER_URI = '/plato/retrieve/roster/students';

/// The [RosterService] class...
class RosterService {
  Map<String, Roster> _rosters;

  Map<String, Roster> get rosters => Map<String, Roster>.from (_rosters);

  final Client _http;

  static RosterService _instance;

  /// The [RosterService] factory constructor...
  factory RosterService (Client http) => _instance ?? RosterService._ (http);

  /// The [RosterService] private constructor...
  RosterService._ (this._http) {
    _rosters = <String, Roster>{};
  }

  /// The [loadRosterForCourse] method...
  Future<void> loadRosterForCourse (String courseId) async {
    if (_rosters.containsKey (courseId)) {
      return;
    }

    try {
      var response = await _http.get ('$_ROSTER_URI?course=$courseId');

      List<Map<String, String>> rawRoster =
        (decodeResponse (response) as Map)['roster'];

      _rosters[courseId] = RosterFactory.create (courseId, rawRoster);
    } catch (_) {
      throw ImproperRoster ('Unable to retrieve the course roster.\n${_.toString()}');
    }
  }

  /// The [getRosterForCourse] method...
  Future<Roster> getRosterForCourse (String courseId) async {
    if (!_rosters.containsKey (courseId)) {
      await loadRosterForCourse (courseId);
    }

    return _rosters[courseId];
  }

  /// The [haveRosterForCourse] method...
  bool haveRosterForCourse (String courseId) => _rosters.containsKey (courseId);
}
