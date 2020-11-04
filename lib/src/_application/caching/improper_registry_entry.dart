library plato.archives.error.registry.entry.improper;

import 'package:plato.cap/src/_application/error/plato_exception.dart';

/// The [ImproperRegistryEntry] class...
class ImproperRegistryEntry extends PlatoException {
  /// The [ImproperRegistryEntry] constructor...
  ImproperRegistryEntry (
    [String message = 'An unknown improper registry entry error has occurred.']
  ) : super (message);
}
