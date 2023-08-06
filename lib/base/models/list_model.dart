import 'base_model.dart';

class ResponseListModel<T extends BaseModel<T>> {
  ResponseListModel();
  List<T>? items;

  ResponseListModel.fromJson(dynamic json, T Function() creator) {
    final items = json['Items'] as List?;
    if (items != null) {
      this.items =
          items.map<T>((dynamic e) => creator().parsedJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Items'] = items?.map((e) => e.toJson()).toList();
    return _data;
  }
}
