import '../cached/base_cached_local.dart';

enum HTTPMethod { get, post, delete, put, patch }

abstract class BaseApiSetup {
  String getPath(dynamic appendPath);

  HTTPMethod get method;

  String? contentType = 'application/x-www-form-urlencoded';

  //save json to local
  CachedLocalType? cachedType;

  String get apiName;
}
