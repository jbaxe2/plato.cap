library plato.cap.components.user.patron.authorization;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

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
  providers: [PatronService]
)
class PatronAuthorizationComponent implements OnInit {
  bool get isAuthorized => _patronService.isAuthorized;

  final PatronService _patronService;

  final EnrollmentsService _enrollmentsService;

  /// The [PatronAuthorizationComponent] constructor...
  PatronAuthorizationComponent (this._patronService, this._enrollmentsService);

  /// The [ngOnInit] method...
  @override
  Future<void> ngOnInit() async {
    try {
      await _patronService.retrieveSession();
      await _patronService.authorizePatron();

      if (isAuthorized) {
        await _retrievePatronAndEnrollments();
      }
    } catch (_) {}
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
      await _patronService.retrievePatron();
      await _enrollmentsService.retrieveEnrollments (_patronService.patron);
    }
  }
}
