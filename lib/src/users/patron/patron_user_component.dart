library plato.cap.components.user.patron;

import 'package:angular/angular.dart';

import 'package:plato.cap/src/users/patron/patron_authorization_component.dart';
import 'package:plato.cap/src/users/patron/patron_service.dart';
import 'package:plato.cap/src/users/patron/patron_user.dart';

/// The [PatronUserComponent] class...
@Component(
  selector: 'patron-user',
  templateUrl: 'patron_user_component.html',
  directives: [
    NgIf,
    PatronAuthorizationComponent
  ],
  providers: [PatronService]
)
class PatronUserComponent implements AfterViewInit {
  PatronUser get patron => _patronService.patron;

  bool get isAuthorized => _patronService.isAuthorized;

  final PatronService _patronService;

  /// The [PatronUserComponent] constructor...
  PatronUserComponent (this._patronService);

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {}
}
