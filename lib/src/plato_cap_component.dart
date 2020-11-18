library plato.cap.component;

import 'package:angular/angular.dart';

import 'package:angular_components/angular_components.dart';
import 'package:angular_components/utils/browser/dom_service/angular_2.dart';
import 'package:angular_components/utils/angular/scroll_host/angular_2.dart';

import 'package:plato.cap/src/_application/error/error_component.dart';
import 'package:plato.cap/src/_application/progress/progress_component.dart';
import 'package:plato.cap/src/_application/workflow/workflow_component.dart';

/// The [PlatoCapComponent] class...
@Component(
  selector: 'plato-cap',
  templateUrl: 'plato_cap_component.html',
  styleUrls: ['plato_cap_component.css'],
  directives: [
    ErrorComponent, ProgressComponent, WorkflowComponent
  ],
  providers: [
    materialProviders, domServiceBinding, scrollHostProviders, popupBindings
  ]
)
class PlatoCapComponent {
  /// The [PlatoCapComponent] constructor...
  PlatoCapComponent();
}
