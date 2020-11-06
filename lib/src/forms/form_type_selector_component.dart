library plato.cap.components.selector.form;

import 'package:angular/angular.dart';

/// The [FormTypeSelectorComponent] class...
@Component(
  selector: 'form-type-selector'
)
class FormTypeSelectorComponent implements AfterViewInit {
  String selectedFormType;

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
