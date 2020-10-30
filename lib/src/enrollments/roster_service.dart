library plato.cap.services.roster;

import 'package:http/http.dart' show Client;

import 'package:plato.cap/src/_application/_utility/functions.dart';
import 'package:plato.cap/src/enrollments/improper_roster.dart';
import 'package:plato.cap/src/enrollments/roster.dart';
import 'package:plato.cap/src/enrollments/roster_factory.dart';

const String _ROSTER_URI = '/plato/retrieve/roster';

/// The [RosterService] class...
class RosterService {
  List<Roster> _rosters;

  List<Roster> get rosters => List<Roster>.from (_rosters);

  final Client _http;

  static RosterService _instance;

  /// The [RosterService] factory constructor...
  factory RosterService (Client http) => _instance ?? RosterService._ (http);

  /// The [RosterService] private constructor...
  RosterService._ (this._http);

  /// The [loadRosterForCourse] method...
  Future<void> loadRosterForCourse (String courseId) async {
    if (_checkIfHaveRoster (courseId)) {
      return;
    }

    try {
      var response = await _http.get (_ROSTER_URI);

      List<Map<String, String>> rawRoster =
        (decodeResponse (response) as Map)['roster'];

      _rosters.add (RosterFactory.create (courseId, rawRoster));
    } catch (_) {
      throw ImproperRoster ('Unable to retrieve the course roster.');
    }
  }

  /// The [_checkIfHaveRoster] method...
  bool _checkIfHaveRoster (String courseId) {
    return _rosters.any ((Roster roster) => roster.courseId == courseId);
  }
}
