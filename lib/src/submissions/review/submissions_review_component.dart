library plato.cap.components.submissions.review;

import 'package:angular/angular.dart';

import 'package:plato.cap/src/_application/caching/caching_service.dart';
import 'package:plato.cap/src/_application/progress/progress_service.dart';
import 'package:plato.cap/src/_application/workflow/workflow_service.dart';
import 'package:plato.cap/src/enrollments/enrollment.dart';
import 'package:plato.cap/src/enrollments/roster_service.dart';
import 'package:plato.cap/src/groups/groups_service.dart';

/// The [SubmissionsReviewComponent] class...
@Component(
  selector: 'submissions-review',
  templateUrl: 'submissions_review_component.html',
  providers: [
    CachingService, GroupsService, ProgressService, RosterService, WorkflowService
  ]
)
class SubmissionsReviewComponent implements AfterViewInit {
  PatronEnrollment _enrollment;

  String _formType;

  final CachingService _cachingService;

  final GroupsService _groupsService;

  final ProgressService _progressService;

  final RosterService _rosterService;

  final WorkflowService _workflowService;

  /// The [SubmissionsReviewComponent] constructor...
  SubmissionsReviewComponent (
    this._cachingService, this._groupsService, this._progressService,
    this._rosterService, this._workflowService
  );

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {
    _workflowService.workflowStream.listen ((String workflowEvent) async {
      if ('submissions.reviewable' == workflowEvent) {
        _loadCachedConditions();

        if (!_rosterService.haveRosterForCourse (_enrollment.courseId)) {
          await _loadCourseRoster();
        }

        if (!_groupsService.haveGroupsForCourse (_enrollment.courseId)) {
          await _loadCourseGroups();
        }
      }
    });
  }

  /// The [_loadCachedConditions] method...
  void _loadCachedConditions() {
    if (_cachingService.haveCachedObject ('selectedEnrollment')) {
      _enrollment = _cachingService.retrieveCachedObject ('selectedEnrollment');
    }

    if (_cachingService.haveCachedObject ('mostRecentFormType')) {
      _formType = _cachingService.retrieveCachedObject ('mostRecentFormType');
    }
  }

  /// The [_loadCourseRoster] method...
  Future<void> _loadCourseRoster() async {
    try {
      _progressService.invoke ('Loading the roster for the CAP course.');

      await _rosterService.loadRosterForCourse (_enrollment.courseId);
    } catch (_) {}

    _progressService.revoke();
  }

  /// The [_loadCourseGroups] method...
  Future<void> _loadCourseGroups() async {
    try {
      _progressService.invoke ('Loading groups for the CAP course.');

      await _groupsService.loadGroupsForCourse (_enrollment.courseId);
    } catch (_) {}

    _progressService.revoke();
  }
}
