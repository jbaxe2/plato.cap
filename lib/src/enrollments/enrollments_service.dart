library plato.cap.services.enrollments;

import 'package:http/http.dart' show Client;

import 'package:plato.cap/src/_application/_utility/functions.dart';
import 'package:plato.cap/src/enrollments/enrollment.dart';
import 'package:plato.cap/src/enrollments/improper_enrollment.dart';
import 'package:plato.cap/src/enrollments/patron_enrollments.dart';
import 'package:plato.cap/src/users/patron/patron_user.dart';

const String _ENROLLMENTS_URI = '/plato/retrieve/enrollments/instructor';

/// The [EnrollmentsService] class...
class EnrollmentsService {
  PatronEnrollments _enrollments;

  PatronEnrollments get enrollments => _enrollments;

  final Client _http;

  static EnrollmentsService _instance;

  /// The [EnrollmentsService] factory constructor...
  factory EnrollmentsService (Client http) =>
    _instance ?? EnrollmentsService._ (http);

  /// The [EnrollmentsService] private constructor...
  EnrollmentsService._ (this._http);

  /// The [retrieveEnrollments] method...
  Future<void> retrieveEnrollments (PatronUser patron) async {
    try {
      var response = await _http.get (_ENROLLMENTS_URI);

      List<Map<String, String>> rawEnrollments =
        (decodeResponse (response) as Map)['enrollments'];

      _enrollments = PatronEnrollments (patron, _parseEnrollments (rawEnrollments));
    } catch (_) {
      throw ImproperEnrollment ('Unable to retrieve the enrollments.');
    }
  }

  /// The [_parseEnrollments] method...
  List<Enrollment> _parseEnrollments (List<Map<String, String>> rawEnrollments) {
    return <Enrollment>[];
  }
}
