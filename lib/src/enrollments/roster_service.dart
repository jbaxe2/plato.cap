library plato.cap.services.roster;

import 'package:http/http.dart' show Client;
import 'package:plato.cap/src/enrollments/roster.dart';

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
    ;
  }
}
