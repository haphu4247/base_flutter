import '../models/cached_response_model.dart';
import 'base_local_data_key_ext.dart';

enum CachedLocalType {
  withinDay,
  oneDay,
  oneWeek,
}

extension CachedLocalTypeExt on CachedLocalType {
  Future<CachedResponseModel?> read(String key) {
    return LocalDataKeyExt.read<CachedResponseModel>(key, CachedResponseModel())
        .then(_matchedType);
  }

  void save(String key, CachedResponseModel value) {
    value.type = this;
    LocalDataKeyExt.save<CachedResponseModel>(key, value);
  }

  CachedResponseModel? _matchedType(CachedResponseModel? value) {
    if (value == null) {
      return null;
    }
    final now = DateTime.now();
    switch (this) {
      case CachedLocalType.withinDay:
        if (value.equalDay(now)) {
          return value;
        }
        break;
      case CachedLocalType.oneDay:
        final diffDuration = now.difference(value.lastSaveDate);
        if (diffDuration.inDays < 1) {
          return value;
        }
        break;
      case CachedLocalType.oneWeek:
        final diffDuration = now.difference(value.lastSaveDate);
        if (diffDuration.inDays < 7) {
          return value;
        }
        break;
    }
    return null;
  }
}
