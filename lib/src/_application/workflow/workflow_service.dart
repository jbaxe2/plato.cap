library plato.cap.services.workflow;

import 'dart:async';

/// The [WorkflowService] class...
class WorkflowService {
  StreamController<bool> _workflowController;

  Stream<bool> get workflowStream => _workflowController.stream;

  static WorkflowService _instance;

  /// The [WorkflowService] factory constructor...
  factory WorkflowService() => _instance ?? (_instance = WorkflowService._());

  /// The [WorkflowService] private constructor...
  WorkflowService._() {
    _workflowController = StreamController<bool>.broadcast();
  }

  /// The [markPatronAuthorized] method...
  void markPatronAuthorized() => _workflowController.add (true);

  /// The [markEnrollmentSelected] method...
  void markEnrollmentSelected() => _workflowController.add (true);

  /// The [markFormTypeSelected] method...
  void markFormTypeSelected() => _workflowController.add (true);
}
