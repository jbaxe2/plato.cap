library plato.cap.components.enrollments;

import 'package:angular/angular.dart';

import 'package:plato.cap/src/enrollments/enrollments_service.dart';
import 'package:plato.cap/src/enrollments/patron_enrollments.dart';

/// The [EnrollmentsComponent] class...
@Component(
  selector: 'enrollments',
  providers: [EnrollmentsService]
)
class EnrollmentsComponent implements OnInit {
  PatronEnrollments get enrollments => _enrollmentsService.enrollments;

  final EnrollmentsService _enrollmentsService;

  /// The [EnrollmentsComponent] constructor...
  EnrollmentsComponent (this._enrollmentsService);

  /// The [ngOnInit] method...
  @override
  void ngOnInit() {}
}
