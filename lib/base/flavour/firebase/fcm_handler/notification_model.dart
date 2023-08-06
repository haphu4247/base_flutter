import 'dart:convert';

import 'package:base_flutter/base/models/base_model.dart';

class NotificationModel extends BaseModel<NotificationModel> {
  NotificationModel();
  String? url;
  dynamic payload;

  factory NotificationModel.fromJson(dynamic json) {
    final model = NotificationModel();
    model.payload = json;
    if (json is String) {
      final jsonData = jsonDecode(json);
      model.url = jsonData['url'] as String?;
    } else if (json is Map) {
      model.url = json['url'] as String?;
    }
    return model;
  }

  @override
  NotificationModel parsedJson(dynamic json) {
    return NotificationModel.fromJson(json);
  }

  @override
  Map toJson() {
    return {'Url': url};
  }
}
