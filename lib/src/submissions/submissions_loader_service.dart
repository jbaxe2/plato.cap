library plato.cap.services.submissions.loader;

import 'dart:async' show Future;

import 'package:http/http.dart' show Client;

/// The [SubmissionsLoaderService] class...
class SubmissionsLoaderService {
  final Client _http;

  static SubmissionsLoaderService _instance;

  /// The [SubmissionsLoaderService] factory constructor...
  factory SubmissionsLoaderService (Client http) =>
    _instance ?? (_instance = SubmissionsLoaderService._ (http));

  /// The [SubmissionsLoaderService] private constructor...
  SubmissionsLoaderService._ (this._http);

  /// The [loadSubmissions] method...
  Future<void> loadSubmissions (String courseId, String formType) async {}
}
