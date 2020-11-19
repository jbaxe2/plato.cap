library plato.cap.components.enrollments;

import 'package:angular/angular.dart';

import 'package:angular_components/angular_components.dart';

import 'package:plato.cap/src/_application/caching/caching_service.dart';
import 'package:plato.cap/src/_application/workflow/workflow_service.dart';
import 'package:plato.cap/src/enrollments/enrollment.dart';
import 'package:plato.cap/src/enrollments/enrollments_service.dart';
import 'package:plato.cap/src/enrollments/patron_enrollments.dart';

/// The [EnrollmentsComponent] class...
@Component(
  selector: 'enrollments',
  templateUrl: 'enrollments_component.html',
  directives: [
    NgIf, NgFor, NgModel,
    MaterialRadioGroupComponent, MaterialRadioComponent
  ],
  providers: [CachingService, EnrollmentsService, WorkflowService]
)
class EnrollmentsComponent implements AfterViewInit {
  PatronEnrollments _enrollments;

  PatronEnrollments get enrollments => _enrollments;

  PatronEnrollment selectedEnrollment;

  final CachingService _cachingService;

  final EnrollmentsService _enrollmentsService;

  final WorkflowService _workflowService;

  /// The [EnrollmentsComponent] constructor...
  EnrollmentsComponent (
    this._cachingService, this._enrollmentsService, this._workflowService
  );

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {
    _enrollmentsService.enrollmentsStream.listen (
      (PatronEnrollments enrollments) => _enrollments = enrollments
    );

    _checkForCachedEnrollment();
  }

  /// The [enrollmentSelected] method...
  void enrollmentSelected (PatronEnrollment enrollment) {
    _cachingService.cacheObject (
      'selectedEnrollment', selectedEnrollment = enrollment
    );

    _workflowService.markEnrollmentSelected();
  }

  /// The [_checkForCachedEnrollment] method...
  void _checkForCachedEnrollment() {
    if (_cachingService.haveCachedObject ('selectedEnrollment')) {
      selectedEnrollment =
        _cachingService.retrieveCachedObject ('selectedEnrollment');
    }
  }
}
