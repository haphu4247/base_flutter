import 'base_model.dart';

class EmptyModel extends BaseModel<EmptyModel> {
  EmptyModel();

  @override
  factory EmptyModel.fromJson(dynamic json) {
    return EmptyModel();
  }

  @override
  EmptyModel parsedJson(dynamic json) {
    return this;
  }

  @override
  Map toJson() {
    return <dynamic, dynamic>{};
  }
}
