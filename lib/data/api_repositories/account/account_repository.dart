import 'package:dio/dio.dart';

import '../../../base/api_client/base_api_service.dart';
import 'account_api_setup.dart';

class AccountRepository<T extends BaseApiService> {
  AccountRepository({required T apiClient}) : _apiClient = apiClient;

  final T _apiClient;

  Future<Response<dynamic>> accountInfo(Map<dynamic, dynamic> body) {
    return _apiClient.callApi(AccountApiSetup(AccountApi.accountInfo),
        body: body);
  }

  Future<Response<dynamic>> signup(Map<dynamic, dynamic> body) {
    return _apiClient.callApi(AccountApiSetup(AccountApi.signup), body: body);
  }

  Future<Response<dynamic>> update(
      Map<dynamic, dynamic> body, String accessToken) {
    final header = _apiClient.getAuthHeader(accessToken);
    return _apiClient.callApi(AccountApiSetup(AccountApi.update),
        body: body, headerParams: header);
  }

  Future<Response<dynamic>> changeAvatar(Map<dynamic, dynamic> body) {
    return _apiClient.callApi(AccountApiSetup(AccountApi.changeAvatar),
        body: body);
  }
}
