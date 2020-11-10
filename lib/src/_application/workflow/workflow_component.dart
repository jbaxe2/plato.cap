library plato.cap.components.workflow;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:plato.cap/src/_application/caching/caching_service.dart';
import 'package:plato.cap/src/_application/workflow/workflow_service.dart';
import 'package:plato.cap/src/enrollments/enrollments_component.dart';
import 'package:plato.cap/src/forms/form_type_selector_component.dart';
import 'package:plato.cap/src/users/patron/patron_user_component.dart';

/// The [WorkflowComponent] class...
@Component(
  selector: 'workflow',
  templateUrl: 'workflow_component.html',
  directives: [
    MaterialExpansionPanel,
    PatronUserComponent, EnrollmentsComponent, FormTypeSelectorComponent
  ],
  providers: [CachingService, WorkflowService]
)
class WorkflowComponent implements AfterViewInit {
  final WorkflowService _workflowService;

  final CachingService _cachingService;

  /// The [WorkflowComponent] constructor...
  WorkflowComponent (this._workflowService, this._cachingService);

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {
    if (_cachingService.haveCachedObject ('patronUser')) {
      _workflowService.markPatronAuthorized();
    }
  }
}
