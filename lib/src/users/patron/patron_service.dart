library plato.cap.services.user.patron;

import 'dart:html' show window;
import 'dart:convert' show json, utf8;

import 'package:http/http.dart' show Client, Response;

import 'package:plato.cap/src/users/patron/patron_exception.dart';
import 'package:plato.cap/src/users/patron/patron_user.dart';

const String _LEARN_AUTH_URI = '/plato/authenticate/learn';
const String _SESSION_URI = '/plato/retrieve/session';
const String _USER_URI = '/plato/retrieve/user';

final String _REST_AUTH_URI =
  'https://bbl.westfield.ma.edu/learn/api/public/v1/oauth2/authorizationcode'
  '?redirect_uri=${Uri.encodeFull (window.location.href)}'
  '&client_id=f36e3a35-e275-4090-b2e4-f7590038dec2'
  '&response_type=code&scope=read';

/// The [PatronService] class...
class PatronService {
  PatronUser patron;

  bool _isAuthorized;

  bool get isAuthorized => _isAuthorized;

  bool _isLtiSession;

  bool get isLtiSession => _isLtiSession;

  final Client _http;

  static PatronService _instance;

  /// The [PatronService] factory constructor...
  factory PatronService (Client http) =>
    _instance ?? (_instance = PatronService._ (http));

  /// The [PatronService] private constructor...
  PatronService._ (this._http) {
    _isAuthorized = false;
    _isLtiSession = false;
  }

  /// The [retrieveSession] method...
  Future<void> retrieveSession() async {
    try {
      var response = await _http.get (_SESSION_URI);

      Map<String, String> rawSession =
        (json.decode (utf8.decode (response.bodyBytes)) as Map)['session'];

      if ((rawSession.containsKey ('plato.session.exists')) &&
          (rawSession.containsKey ('learn.user.authenticated'))) {
        if ('true' == rawSession['learn.user.authenticated']) {
          _isAuthorized = true;

          if ((rawSession.containsKey ('plato.lti.session')) &&
            ('true' == rawSession['plato.lti.session'])) {
            _isLtiSession = true;
          }
        }
      }
    } catch (_) {
      throw PatronException ('Unable to determine if a session exists.');
    }
  }
}
