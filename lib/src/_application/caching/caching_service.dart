library plato.archives.services.caching;

import 'package:plato.cap/src/_application/caching/simple_registry.dart';

/// The [CachingService] class...
class CachingService {
  SimpleRegistry _simpleRegistry;

  static CachingService _instance;

  /// The [CachingService] factory constructor...
  factory CachingService() => _instance ?? (_instance = CachingService._());

  /// The [CachingService] private constructor...
  CachingService._() {
    _simpleRegistry = SimpleRegistry();
  }

  /// The [cacheObject] method...
  void cacheObject (String key, Object object) {
    if (_simpleRegistry.contains (key)) {
      _simpleRegistry.refresh (key, object);
    } else {
      _simpleRegistry.register (key, object);
    }
  }

  /// The [haveCachedObject] method...
  bool haveCachedObject (String key) => _simpleRegistry.contains (key);

  /// The [retrieveCachedObject] method...
  dynamic retrieveCachedObject (String key) {
    try {
      return _simpleRegistry.retrieve (key);
    } catch (_) {
      rethrow;
    }
  }

  /// The [removeFromCache] method...
  dynamic removeFromCache (String key) {
    try {
      return _simpleRegistry.unregister (key);
    } catch (_) {
      rethrow;
    }
  }
}
