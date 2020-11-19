library plato.cap.components.selector.form;

import 'package:angular/angular.dart';

import 'package:angular_components/angular_components.dart';
import 'package:plato.cap/src/_application/caching/caching_service.dart';

import 'package:plato.cap/src/_application/workflow/workflow_service.dart';

/// The [FormTypeSelectorComponent] class...
@Component(
  selector: 'form-type-selector',
  templateUrl: 'form_type_selector_component.html',
  directives: [
    NgFor, NgModel,
    MaterialRadioGroupComponent, MaterialRadioComponent
  ],
  providers: [CachingService, WorkflowService]
)
class FormTypeSelectorComponent implements AfterViewInit {
  String selectedFormType;

  final List<String> formTypes = ['Formative', 'Summative'];

  final CachingService _cachingService;

  final WorkflowService _workflowService;

  /// The [FormTypeSelectorComponent] constructor...
  FormTypeSelectorComponent (this._cachingService, this._workflowService);

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {
    if (_cachingService.haveCachedObject ('mostRecentFormType')) {
      selectedFormType =
        _cachingService.retrieveCachedObject ('mostRecentFormType');
    }
  }

  /// The [formTypeSelected] method...
  void formTypeSelected (String formType) {
    _cachingService.cacheObject (
      'mostRecentFormType', selectedFormType = formType
    );

    _workflowService.markFormTypeSelected();
  }
}
