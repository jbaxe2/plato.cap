library plato.cap.components.enrollments;

import 'package:angular/angular.dart';

import 'package:angular_components/angular_components.dart';

import 'package:plato.cap/src/_application/caching/caching_service.dart';
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
  providers: [CachingService, EnrollmentsService]
)
class EnrollmentsComponent implements AfterViewInit {
  PatronEnrollments get enrollments => _enrollmentsService.enrollments;

  final CachingService _cachingService;

  final EnrollmentsService _enrollmentsService;

  PatronEnrollment selectedEnrollment;

  /// The [EnrollmentsComponent] constructor...
  EnrollmentsComponent (this._cachingService, this._enrollmentsService);

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {
    _checkForCachedEnrollment();
  }

  /// The [enrollmentSelected] method...
  void enrollmentSelected (PatronEnrollment enrollment) {
    _cachingService.cacheObject (
      'selectedEnrollment', selectedEnrollment = enrollment
    );
  }

  /// The [_checkForCachedEnrollment] method...
  void _checkForCachedEnrollment() {
    if (_cachingService.haveCachedObject ('selectedEnrollment')) {
      selectedEnrollment =
        _cachingService.retrieveCachedObject ('selectedEnrollment');
    }
  }
}
