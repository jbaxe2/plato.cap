library plato.cap.components.enrollments;

import 'package:angular/angular.dart';

import 'package:plato.cap/src/enrollments/enrollment.dart';
import 'package:plato.cap/src/enrollments/enrollments_service.dart';
import 'package:plato.cap/src/enrollments/patron_enrollments.dart';

/// The [EnrollmentsComponent] class...
@Component(
  selector: 'enrollments',
  providers: [EnrollmentsService]
)
class EnrollmentsComponent implements AfterViewInit {
  PatronEnrollments get enrollments => _enrollmentsService.enrollments;

  final EnrollmentsService _enrollmentsService;

  PatronEnrollment selectedEnrollment;

  /// The [EnrollmentsComponent] constructor...
  EnrollmentsComponent (this._enrollmentsService);

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {}

  /// The [enrollmentSelected] method...
  void enrollmentSelected (PatronEnrollment enrollment) {
    selectedEnrollment = enrollment;
  }
}
