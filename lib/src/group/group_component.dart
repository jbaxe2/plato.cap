library plato.cap.components.group;

import 'package:angular/angular.dart';

import 'package:plato.cap/src/group/groups_service.dart';

/// The [GroupComponent] class...
class GroupComponent implements AfterViewInit {
  final GroupsService _groupsService;

  /// The [GroupComponent] constructor...
  GroupComponent (this._groupsService);

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {}
}
