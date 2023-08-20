import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../features/auth/data/datasources/authentication_local_data_source.dart';
import 'api_constants.dart';
import 'api_exceptions.dart';

class ApiClient {
  final AuthenticationLocalDataSource _authenticationLocalDataSource;
  final Client _client;

  ApiClient(this._client, this._authenticationLocalDataSource);

  Future<dynamic> get(
    String path, {
    Map<dynamic, dynamic>? params,
    String? baseUrl,
  }) async {
    String sessionId =
        await _authenticationLocalDataSource.getSessionId() ?? "";

    final pth = getPath(path, params, baseUrl);

    debugPrint("Pth $pth");

    final response = await _client.get(
      pth, //?format=json
      headers: {
        'Authorization': 'Bearer $sessionId',
        'Accept': 'application/json',
      },
    );

    // print("Stat ${response.statusCode} Response ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 400) {
      String msg = "unknown_error";
      var resp = jsonDecode(utf8.decode(response.bodyBytes));
      if (resp.containsKey("error")) {
        msg = resp["error"];
      } else if (resp.containsKey("message")) {
        var rsp = resp["message"];
        if (rsp.runtimeType == String) msg = resp["message"];
        if (rsp.runtimeType == List) msg = rsp[0];
      } else {
        msg = utf8
            .decode(response.bodyBytes)
            .replaceAll("[", '')
            .replaceAll("]", '')
            .replaceAll("}", '')
            .replaceAll("{", '')
            .replaceAll("\\", '');
      }
      throw ExceptionWithMessage(msg);
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<dynamic> post(String path,
      {Map<dynamic, dynamic>? params,
      bool withToken = true,
      bool withBaseUrl = true,
      bool isFirebase = false}) async {
    String sessionId =
        await _authenticationLocalDataSource.getSessionId() ?? "";
    Map<String, String> userHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (kDebugMode) {
      print("Request params: $params ");
    }
    if (sessionId != '' && withToken) {
      userHeader.addAll({'Authorization': 'Bearer $sessionId'});
    }

    final uri = Uri.parse(withBaseUrl ? ApiConstants.baseApiUrl + path : path);

    final response = await _client.post(
      uri,
      body: jsonEncode(params),
      headers: userHeader,
    );
    if (kDebugMode) {
      debugPrint("Post uri = $uri");
      debugPrint("Post header = $userHeader");
      debugPrint("Post body =  ${jsonEncode(params)}");
      debugPrint("API post response: ${response.statusCode} ");
      print(utf8.decode(response.bodyBytes));
    }

    if (response.statusCode == 400 ||
        response.statusCode == 403 ||
        response.statusCode == 405) {
      String msg = "unknown_error";
      Map<String, dynamic> resp = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint("Resp $resp");
      if (resp.containsKey("error")) {
        if (isFirebase) {
          msg = resp["error"]['message'];
        } else {
          msg = resp["error"];
        }
      } else if (resp.containsKey("message")) {
        var rsp = resp["message"];
        if (rsp.runtimeType == String) msg = resp["message"];
        if (rsp.runtimeType == List) msg = rsp[0];
      } else {
        msg = utf8
            .decode(response.bodyBytes)
            .replaceAll("[", '')
            .replaceAll("]", '')
            .replaceAll("}", '')
            .replaceAll("{", '')
            .replaceAll("\\", '');
      }

      debugPrint("Expetion with message");
      throw ExceptionWithMessage(msg);
    }
    if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else if (response.statusCode == 404) {
      throw const ExceptionWithMessage("Not found");
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Everyt thing ok");
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      debugPrint("Exception ${response.reasonPhrase}");
      throw Exception(response.reasonPhrase);
    }
  }

  Uri getPath(String path, Map<dynamic, dynamic>? params, String? baseUrl) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }

    return Uri.parse('${baseUrl ?? ApiConstants.baseApiUrl}$path$paramsString');
  }
}
