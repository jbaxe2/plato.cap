library plato.cap.components.user.patron.authorization;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:plato.cap/src/_application/progress/progress_service.dart';
import 'package:plato.cap/src/enrollments/enrollments_service.dart';
import 'package:plato.cap/src/users/patron/patron_service.dart';

/// The [PatronAuthorizationComponent] class...
@Component (
  selector: 'patron-authorization',
  templateUrl: 'patron_authorization_component.html',
  styleUrls: ['patron_authorization_component.css'],
  directives: [
    materialInputDirectives,
    MaterialButtonComponent, MaterialIconComponent
  ],
  providers: [EnrollmentsService, PatronService, ProgressService]
)
class PatronAuthorizationComponent implements AfterViewInit {
  bool get isAuthorized => _patronService.isAuthorized;

  final PatronService _patronService;

  final EnrollmentsService _enrollmentsService;

  final ProgressService _progressService;

  /// The [PatronAuthorizationComponent] constructor...
  PatronAuthorizationComponent (
    this._patronService, this._enrollmentsService, this._progressService
  );

  /// The [ngAfterViewInit] method...
  @override
  Future<void> ngAfterViewInit() async {
    try {
      _progressService.invoke ('Determining launch context.');

      await _patronService.retrieveSession();
      await _patronService.authorizePatron();

      if (isAuthorized) {
        await _retrievePatronAndEnrollments();
      }
    } catch (_) {}

    _progressService.revoke();
  }

  /// The [authorize] method...
  Future<void> authorize() async {
    try {
      if (!isAuthorized) {
        _patronService.authorizeApplication();
      } else {
        await _retrievePatronAndEnrollments();
      }
    } catch (_) {}
  }

  /// The [_retrievePatronAndEnrollments] method...
  Future<void> _retrievePatronAndEnrollments() async {
    if (isAuthorized) {
      _progressService.invoke ('Retrieving the patron information.');
      await _patronService.retrievePatron();

      _progressService.invoke ('Retrieving the patron enrollments.');
      await _enrollmentsService.retrieveEnrollments (_patronService.patron);
    }
  }
}
