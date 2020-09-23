library plato.cap.components.forms.formative;

import 'package:angular/angular.dart';

import 'package:plato.cap/src/forms/formative/formative.dart';

/// The [FormativeComponent] class...
@Component(
  selector: 'formative',
  templateUrl: 'formative_component.html'
)
class FormativeComponent {
  @Input()
  FormativeForm formativeForm;

  /// The [FormativeComponent] constructor...
  FormativeComponent();
}
