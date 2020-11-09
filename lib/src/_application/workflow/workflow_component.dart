library plato.cap.components.workflow;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:plato.cap/src/_application/caching/caching_service.dart';
import 'package:plato.cap/src/_application/workflow/workflow_service.dart';

/// The [WorkflowComponent] class...
@Component(
  selector: 'workflow',
  directives: [MaterialExpansionPanel],
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
