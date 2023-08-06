import '../../shared/utils/utils_string.dart';
import 'base_model.dart';

abstract class BaseResponse<E> extends BaseModel<E> {
  // BaseResponse();

  String? isOK;
  String? resultCode;
  String? resultMessage;
  dynamic data;
  dynamic list;
  String dataKey = '';

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'IsOK': isOK,
      'ResultCode': resultCode,
      'ResultMessage': resultMessage,
      'data': data,
    };
  }

  @override
  E parsedJson(dynamic json) {
    return _parseObject(json);
  }

  E _parseObject(dynamic json) {
    isOK = json['IsOK'] as String? ?? UtilsString.parse(json['status']);

    resultCode =
        json['ResultCode'] as String? ?? UtilsString.parse(json['code']);

    resultMessage =
        json['ResultMessage'] as String? ?? UtilsString.parse(json['message']);
    if (dataKey.isEmpty) {
      data = json;
    } else {
      data = json[dataKey];
    }
    return this as E;
  }

  bool isSuccess() {
    final msg = resultMessage?.toLowerCase();
    return 'true' == isOK || msg?.contains('success') == true;
  }
}
