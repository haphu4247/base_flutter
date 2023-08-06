import 'base_api_setup.dart';

abstract class BaseParams {
  String get url;
  HTTPMethod get method;
  dynamic get body;
  Map<String, String>? get headers;
  Map<String, dynamic>? get query;
  String? contentType;
  factory BaseParams(
      {String? baseUrl,
      String? appendPath,
      required BaseApiSetup apiSetup,
      dynamic bodyParams,
      Map<String, dynamic>? queryParams,
      Map<String, String>? headerParams}) {
    return _BaseParamsImpl(
      apiSetup: apiSetup,
      baseUrl: baseUrl,
      appendPath: appendPath,
      bodyParams: bodyParams,
      queryParams: queryParams,
      headerParams: headerParams,
    );
  }

  BaseParams._internal();
}

class _BaseParamsImpl extends BaseParams {
  final String? baseUrl;
  final String? appendPath;
  final BaseApiSetup apiSetup;
  final dynamic bodyParams;
  final Map<String, dynamic>? queryParams;
  final Map<String, String>? headerParams;

  _BaseParamsImpl({
    required this.apiSetup,
    this.baseUrl,
    this.appendPath,
    this.bodyParams,
    this.queryParams,
    this.headerParams,
  }) : super._internal();

  @override
  String get url => '$baseUrl${apiSetup.getPath(appendPath)}';

  @override
  HTTPMethod get method => apiSetup.method;

  @override
  dynamic get body => bodyParams;

  @override
  Map<String, String>? get headers => headerParams;

  @override
  Map<String, dynamic>? get query => queryParams;
}
