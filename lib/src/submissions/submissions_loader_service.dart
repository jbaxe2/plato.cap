library plato.cap.services.submissions.loader;

import 'package:http/http.dart' show Client;
import 'package:plato.cap/src/forms/cap_form.dart';
import 'package:plato.cap/src/forms/improper_cap_form.dart';

const String _LOADER_URI = '/plato/load/submissions/cap';

/// The [SubmissionsLoaderService] class...
class SubmissionsLoaderService {
  Map<String, List<CapForm>> _submissions;

  final Client _http;

  static SubmissionsLoaderService _instance;

  /// The [SubmissionsLoaderService] factory constructor...
  factory SubmissionsLoaderService (Client http) =>
    _instance ?? (_instance = SubmissionsLoaderService._ (http));

  /// The [SubmissionsLoaderService] private constructor...
  SubmissionsLoaderService._ (this._http) {
    _submissions = <String, List<CapForm>>{};
  }

  /// The [loadSubmissions] method...
  Future<void> loadSubmissions (
    String courseId, String formType, List<String> userIds
  ) async {
    if (_submissions.containsKey (courseId)) {
      return;
    }

    try {
      var response = _http.get (
        '$_LOADER_URI?course=$courseId&type=$formType&userIds=${userIds.join (',')}'
      );
    } catch (_) {
      throw ImproperCapForm ();
    }
  }
}
