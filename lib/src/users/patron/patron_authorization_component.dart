library plato.cap.components.user.patron.authorization;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

/// The [PatronAuthorizationComponent] class...
@Component (
  selector: 'patron-authorization',
  templateUrl: 'patron_authorization_component.html',
  styleUrls: ['patron_authorization_component.css'],
  directives: [
    materialInputDirectives, MaterialButtonComponent, MaterialIconComponent
  ],
  providers: []
)
class PatronAuthorizationComponent {
  /// The [PatronAuthorizationComponent] constructor...
  PatronAuthorizationComponent();
}
