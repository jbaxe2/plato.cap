library plato.cap.components.user.patron.authorization;

import 'package:angular/angular.dart';

import 'package:angular_components/angular_components.dart';

import 'package:plato.cap/src/_application/caching/caching_service.dart';
import 'package:plato.cap/src/_application/progress/progress_service.dart';
import 'package:plato.cap/src/_application/workflow/workflow_service.dart';
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
  providers: [
    CachingService, EnrollmentsService, PatronService, ProgressService,
    WorkflowService
  ]
)
class PatronAuthorizationComponent implements AfterViewInit {
  bool get isAuthorized => _patronService.isAuthorized;

  final PatronService _patronService;

  final EnrollmentsService _enrollmentsService;

  final CachingService _cachingService;

  final ProgressService _progressService;

  final WorkflowService _workflowService;

  /// The [PatronAuthorizationComponent] constructor...
  PatronAuthorizationComponent (
    this._patronService, this._enrollmentsService, this._cachingService,
    this._progressService, this._workflowService
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

        _workflowService.markPatronAuthorized();
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

        _cachingService.cacheObject ('patronUser', _patronService.patron);
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
