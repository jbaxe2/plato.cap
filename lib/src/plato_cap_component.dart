library plato.cap.component;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:plato.cap/src/_application/workflow/workflow_component.dart';

/// The [PlatoCapComponent] class...
@Component(
  selector: 'plato-cap',
  templateUrl: 'plato_cap_component.html',
  styleUrls: ['plato_cap_component.css'],
  directives: [WorkflowComponent],
  providers: [materialProviders]
)
class PlatoCapComponent {
  /// The [PlatoCapComponent] constructor...
  PlatoCapComponent();
}
