library plato.cap.services.workflow;

import 'dart:async' show StreamController, Stream;

/// The [WorkflowService] class...
class WorkflowService {
  StreamController<String> _workflowController;

  Stream<String> get workflowStream => _workflowController.stream;

  static WorkflowService _instance;

  /// The [WorkflowService] factory constructor...
  factory WorkflowService() => _instance ?? (_instance = WorkflowService._());

  /// The [WorkflowService] private constructor...
  WorkflowService._() {
    _workflowController = StreamController<String>.broadcast();
  }

  /// The [markPatronAuthorized] method...
  void markPatronAuthorized() => _workflowController.add ('patron.authorized');

  /// The [markEnrollmentSelected] method...
  void markEnrollmentSelected() => _workflowController.add ('enrollment.selected');

  /// The [markFormTypeSelected] method...
  void markFormTypeSelected() => _workflowController.add ('form.type.selected');
}
