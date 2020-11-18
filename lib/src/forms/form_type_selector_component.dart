library plato.cap.components.selector.form;

import 'package:angular/angular.dart';

import 'package:angular_components/angular_components.dart';

/// The [FormTypeSelectorComponent] class...
@Component(
  selector: 'form-type-selector',
  templateUrl: 'form_type_selector_component.html',
  directives: [
    NgFor, NgModel,
    MaterialRadioGroupComponent, MaterialRadioComponent
  ]
)
class FormTypeSelectorComponent implements AfterViewInit {
  String selectedFormType;

  final List<String> formTypes = ['Formative', 'Summative'];

  /// The [FormTypeSelectorComponent] constructor...
  FormTypeSelectorComponent();

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {}

  /// The [formTypeSelected] method...
  void formTypeSelected (String formType) {
    selectedFormType = formType;
  }
}
