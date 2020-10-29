library plato.cap.components.user.patron.authorization;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

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

  /// The [PatronAuthorizationComponent] constructor...
  PatronAuthorizationComponent (this._patronService);

  /// The [ngOnInit] method...
  @override
  Future<void> ngOnInit() async {
    try {
      await _patronService.retrieveSession();
      await _patronService.authorizePatron();

      if (isAuthorized) {
        await _patronService.retrievePatron();
      }
    } catch (_) {}
  }

  /// The [authorize] method...
  Future<void> authorize() async {
    try {
      if (!isAuthorized) {
        _patronService.authorizeApplication();
      }

      await _patronService.retrievePatron();
    } catch (_) {}
  }
}
