import 'dart:io';

import 'package:base_flutter/base/cached/base_cached_local.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../../shared/utils/my_log.dart';
import '../flavour/environment.dart';
import '../models/cached_response_model.dart';
import 'base_api_setup.dart';
import 'base_params.dart';

abstract class BaseApiService {
  factory BaseApiService() {
    return _BaseApiServiceImpl();
  }
  BaseApiService._internal();

  Future<Response<dynamic>> callApi(
    BaseApiSetup apiSetup, {
    String? appendPath,
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headerParams,
  });

  Future<Response<dynamic>> uploadFile(
    BaseApiSetup apiSetup,
    String userId,
    String accessToken,
    List<File> body, {
    String? appendPath,
  }) {
    throw UnimplementedError();
  }

  Map<String, String> getAuthHeader(String accessToken) {
    return {
      'authorization': 'Bearer $accessToken',
      'accept': 'application/json'
    };
  }
}

class _BaseApiServiceImpl extends BaseApiService {
  _BaseApiServiceImpl() : super._internal() {
    _onInit();
  }

  final String apiHost = Environment.instance.config.apiHost;
  late final Dio dio;
  void _onInit() {
    final options = BaseOptions(
      baseUrl: apiHost,
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 45),
      sendTimeout: const Duration(seconds: 45),
    );
    dio = Dio(options);
  }

  @override
  Future<Response<dynamic>> callApi(BaseApiSetup apiSetup,
      {String? appendPath,
      dynamic body,
      Map<String, dynamic>? queryParams,
      Map<String, String>? headerParams = const {
        'accept': 'application/json'
      }}) async {
    final cachedType = apiSetup.cachedType;
    if (cachedType != null) {
      final json = await cachedType
          .read(apiSetup.apiName)
          .then((value) => value?.response);
      if (json != null) {
        return json;
      }
    }
    return _requestData(
      BaseParams(
          apiSetup: apiSetup,
          baseUrl: apiHost,
          appendPath: appendPath,
          bodyParams: body,
          headerParams: headerParams,
          queryParams: queryParams),
    ).then((value) {
      if (cachedType != null) {
        cachedType.save(apiSetup.apiName, CachedResponseModel(response: value));
      }
      return value;
    });
  }

  @override
  Future<Response<dynamic>> uploadFile(
      BaseApiSetup apiSetup, String userId, String accessToken, List<File> body,
      {String? appendPath}) {
    final list = body.map(
      (e) => MultipartFile.fromFile(
        e.path,
        filename: basename(e.path),
      ),
    );
    final map = <String, dynamic>{
      'file': list,
      'userId': userId,
    };
    final form = FormData.fromMap(map);
    final header = getAuthHeader(accessToken);
    return _requestData(BaseParams(
        baseUrl: apiHost,
        appendPath: appendPath,
        apiSetup: apiSetup,
        bodyParams: form,
        headerParams: header));
  }

  Future<Response<dynamic>> _requestData(BaseParams params) {
    final tempQuery = params.query;
    var fullURL = params.url;
    if (tempQuery != null) {
      fullURL = '$fullURL?${_encodeQueryParameters(tempQuery)}';
    }
    MyLogger.d(this, params.toString());
    final options = Options(
        method: params.method.name,
        contentType: params.contentType,
        headers: params.headers,
        responseType: ResponseType.json);
    return dio.request(
      fullURL,
      options: options,
      data: params.body,
    );
  }

  String _encodeQueryParameters(Map<dynamic, dynamic> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent('${e.key}')}=${Uri.encodeComponent('${e.value}')}')
        .join('&');
  }

  // ignore: unused_element
  String _queryParameters(Map<dynamic, dynamic> params) {
    return params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }
}
