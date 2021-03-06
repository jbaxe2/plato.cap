library plato.crf.components.application.progress;

import 'package:angular/angular.dart';

import 'package:angular_components/angular_components.dart';

import 'package:plato.cap/src/_application/progress/progress_service.dart';

/// The [ProgressComponent] class...
@Component(
  selector: 'plato-progress',
  templateUrl: 'progress_component.html',
  styleUrls: ['progress_component.css'],
  directives: [
    AutoFocusDirective, ModalComponent, MaterialDialogComponent,
    MaterialIconComponent, MaterialProgressComponent
  ],
  providers: [ProgressService, popupBindings]
)
class ProgressComponent implements AfterViewInit {
  bool isVisible;

  String message;

  final String _defaultMessage;

  final ProgressService _progressService;

  /// The [ProgressComponent] constructor...
  ProgressComponent (
    this._progressService,
    [this._defaultMessage = '(There is no current message to display.)']
  );

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {
    _progressService.messageStreamController.stream.listen (
      (String theMessage) {
        message = theMessage ?? _defaultMessage;

        isVisible = (null != theMessage);
      }
    );
  }
}
