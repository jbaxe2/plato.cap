library plato.cap.component;

import 'package:angular/angular.dart';

import 'package:plato.cap/src/users/patron/patron_user_component.dart';

/// The [PlatoCapComponent] class...
@Component(
  selector: 'plato-cap',
  styleUrls: ['plato_cap_component.css'],
  templateUrl: 'plato_cap_component.html',
  directives: [PatronUserComponent]
)
class PlatoCapComponent {
  /// The [PlatoCapComponent] constructor...
  PlatoCapComponent();
}
