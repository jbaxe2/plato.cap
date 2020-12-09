library plato.cap.components.submissions.review;

import 'package:angular/angular.dart';

import 'package:plato.cap/src/_application/caching/caching_service.dart';
import 'package:plato.cap/src/_application/progress/progress_service.dart';
import 'package:plato.cap/src/_application/workflow/workflow_service.dart';
import 'package:plato.cap/src/enrollments/enrollment.dart';
import 'package:plato.cap/src/enrollments/roster_service.dart';
import 'package:plato.cap/src/groups/groups_service.dart';
import 'package:plato.cap/src/groups/triad_student_determinator_service.dart';
import 'package:plato.cap/src/submissions/submissions_loader_service.dart';

/// The [SubmissionsReviewComponent] class...
@Component(
  selector: 'submissions-review',
  templateUrl: 'submissions_review_component.html',
  providers: [
    CachingService, GroupsService, ProgressService, RosterService,
    SubmissionsLoaderService,  TriadStudentDeterminatorService,
    WorkflowService
  ]
)
class SubmissionsReviewComponent implements AfterViewInit {
  PatronEnrollment _enrollment;

  String _formType;

  final CachingService _cachingService;

  final GroupsService _groupsService;

  final ProgressService _progressService;

  final RosterService _rosterService;

  final SubmissionsLoaderService _submissionsLoaderService;

  final TriadStudentDeterminatorService _studentDeterminatorService;

  final WorkflowService _workflowService;

  /// The [SubmissionsReviewComponent] constructor...
  SubmissionsReviewComponent (
    this._cachingService, this._groupsService, this._progressService,
    this._rosterService, this._submissionsLoaderService,
    this._studentDeterminatorService, this._workflowService
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

        await _loadFormSubmissions();
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

      await _groupsService.loadGroupInfoForCourse (_enrollment.courseId);
    } catch (_) {}

    _progressService.revoke();
  }

  /// The [_loadFormSubmissions] method...
  Future<void> _loadFormSubmissions() async {
    _progressService.invoke ('Loading CAP form submissions.');

    try {
      await _submissionsLoaderService.loadSubmissionsForCourseUsers (
        _enrollment.courseId, await _determineTriadStudents(), _formType
      );
    } catch (_) {}

    _progressService.revoke();
  }

  /// The [_determineTriadStudents] method...
  Future<List<String>> _determineTriadStudents() async {
    _progressService.invoke ('Determining specific triad student users.');

    var haveTriadStudents =
      _studentDeterminatorService.haveTriadStudentsForCourse (_enrollment.courseId);

    var triadStudents = <String>[];

    if (haveTriadStudents) {
      triadStudents = _studentDeterminatorService.getTriadStudentsForCourse (
        _enrollment.courseId
      );
    } else {
      triadStudents = _studentDeterminatorService.determineTriadStudents (
        await _rosterService.getRosterForCourse (_enrollment.courseId),
        _groupsService.getGroupSetsForCourse (_enrollment.courseId),
        _groupsService.getGroupsForCourse (_enrollment.courseId)
      );
    }

    _progressService.revoke();

    return triadStudents;
  }
}
