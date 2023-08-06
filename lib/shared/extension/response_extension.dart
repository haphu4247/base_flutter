import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../base/models/base_response.dart';
import '../../base/models/error_response.dart';
import '../utils/my_log.dart';

extension ResponseExt on Response<dynamic> {
  List<R>? checkResultList<R extends BaseResponse<R>>(
      {required R instance,
      required ValueChanged<List<R>> onSuccess,
      ValueChanged<BaseResponse<dynamic>>? onError,
      VoidCallback? onCompleted,
      bool showSuccessToast = false}) {
    if (data != null) {
      final decodeBody = _parseBody();
      final parseResponse = instance.parsedJson(decodeBody);
      if (parseResponse.isSuccess()) {
        final List<R> list =
            List<dynamic>.from(parseResponse.data as Iterable<dynamic>)
                .map((dynamic e) => instance.parsedJson(e))
                .toList();
        onSuccess(list);
        return list;
      } else {
        _checkError(onError, errBody: decodeBody);
      }
    } else {
      //check Http status code.
      _checkError(onError, code: statusCode?.toString());
    }

    if (onCompleted != null) {
      onCompleted();
    }
    return null;
  }

  R? checkResultModel<R extends BaseResponse<R>>(
      {required R instance,
      required ValueChanged<R> onSuccess,
      ValueChanged<ErrorResponse>? onError,
      VoidCallback? onCompleted,
      bool showErrorToast = true,
      bool showSuccessToast = false}) {
    MyLogger.d(this, 'Response: ${toString()}');
    if (data != null) {
      final decodeBody = _parseBody();
      final model = instance.parsedJson(decodeBody);
      if (instance.isSuccess()) {
        onSuccess(model);
        return model;
      } else {
        _checkError(onError,
            errBody: decodeBody, resultMessage: model.resultMessage);
      }
    } else {
      //check Http status code.
      _checkError(onError, code: statusCode?.toString());
    }

    if (onCompleted != null) {
      onCompleted();
    }
    return null;
  }

  dynamic _parseBody() {
    //parse body if neeed
    return data;
  }

  void _checkError(
    ValueChanged<ErrorResponse>? onError, {
    dynamic errBody,
    String? code,
    String? resultMessage,
    String? resultCode,
  }) {
    final err = ErrorResponse();

    if (errBody != null) {
      err.parsedJson(errBody);
    } else {
      err.resultCode = resultCode;
      err.resultMessage = resultMessage;
    }

    if (onError != null) {
      onError(err);
    }
  }
}
