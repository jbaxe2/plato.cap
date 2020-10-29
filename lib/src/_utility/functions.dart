library plato.cap.utility.functions;

import 'dart:convert' show json, utf8;

import 'package:http/http.dart' show Response;

/// The [decodeResponse] function...
dynamic decodeResponse (Response rawResponse) {
  return json.decode (utf8.decode (rawResponse.bodyBytes));
}
