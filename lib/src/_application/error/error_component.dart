library plato.archives.components.error;

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:plato.cap/src/_application/error/error_service.dart';
import 'package:plato.cap/src/_application/error/plato_exception.dart';

/// The [ErrorComponent] class...
@Component(
  selector: 'plato-error',
  templateUrl: 'error_component.html',
  styleUrls: ['error_component.css'],
  directives: [
    MaterialButtonComponent, MaterialDialogComponent, MaterialIconComponent,
    ModalComponent
  ],
  providers: [ErrorService]
)
class ErrorComponent implements AfterViewInit {
  String error;

  bool showError;

  final ErrorService _errorService;

  /// The [ErrorComponent] constructor...
  ErrorComponent (this._errorService);

  /// The [ngAfterViewInit] method...
  @override
  void ngAfterViewInit() {
    error = 'No errors have occurred.';
    showError = _errorService.errorRaised;

    _errorService.errorStreamController.stream.listen (
      (PlatoException exception) {
        error = exception.toString();
        showError = true;
      }
    );
  }
}
