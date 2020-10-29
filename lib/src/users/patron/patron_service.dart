library plato.cap.services.user.patron;

import 'dart:html' show window;

import 'package:http/http.dart' show Client;

import 'package:plato.cap/src/_application/_utility/functions.dart';
import 'package:plato.cap/src/users/patron/improper_patron.dart';
import 'package:plato.cap/src/users/patron/patron_factory.dart';
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
  PatronUser _patron;

  bool _isAuthorized;

  bool _isLtiSession;

  PatronUser get patron => _patron;

  bool get isAuthorized => _isAuthorized;

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
        (decodeResponse (response) as Map)['session'];

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
      throw ImproperPatron ('Unable to determine if a session exists.');
    }
  }

  /// The [authorizeApplication] method...
  void authorizeApplication() {
    if (_isAuthorized) {
      return;
    }

    window.location.replace (_REST_AUTH_URI);
  }

  /// The [authorizePatron] method...
  Future<bool> authorizePatron() async {
    if (_isAuthorized) {
      return true;
    }

    var location = Uri.parse (window.location.href);

    if (location.queryParameters.containsKey ('code')) {
      try {
        var response = await _http.post (
          Uri.parse (_LEARN_AUTH_URI),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {'authCode': location.queryParameters['code']}
        );

        Map<String, dynamic> result = decodeResponse (response);

        if (true == result['learn.user.authenticated']) {
          _isAuthorized = true;
        } else {
          throw result;
        }
      } catch (_) {
        throw ImproperPatron ('Patron authorization has failed.');
      }

      return true;
    }

    return false;
  }

  /// The [retrievePatron] method...
  Future<void> retrievePatron() async {
    if (!_isAuthorized) {
      throw ImproperPatron ('Cannot retrieve info for unauthorized patron.');
    }

    try {
      var response = await _http.get (_USER_URI);

      Map<String, String> rawPatron = decodeResponse (response);

      _patron = PatronFactory.create (rawPatron);
    } catch (_) {
      throw ImproperPatron ('Unable to retrieve the patron info.');
    }
  }
}
