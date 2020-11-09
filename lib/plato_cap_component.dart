library plato.cap.component;

import 'package:angular/angular.dart';

import 'package:plato.cap/src/_application/workflow/workflow_component.dart';

/// The [PlatoCapComponent] class...
@Component(
  selector: 'plato-cap',
  styleUrls: ['plato_cap_component.css'],
  templateUrl: 'plato_cap_component.html',
  directives: [WorkflowComponent]
)
class PlatoCapComponent {
  /// The [PlatoCapComponent] constructor...
  PlatoCapComponent();
}
