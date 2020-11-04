library plato.archives.services.error;

import 'dart:async' show StreamController;

import 'package:plato.cap/src/_application/error/plato_exception.dart';

/// The [ErrorService] class...
class ErrorService {
  final StreamController<PlatoException> errorStreamController =
    StreamController<PlatoException>.broadcast();

  bool errorRaised;

  static ErrorService _instance;

  /// The [ErrorService] factory constructor...
  factory ErrorService() => _instance ?? (_instance = ErrorService._());

  /// The [ErrorService] private constructor...
  ErrorService._();

  /// The [raiseError] method...
  void raiseError (PlatoException exception) {
    errorStreamController.add (exception);
    errorRaised = true;
  }
}
