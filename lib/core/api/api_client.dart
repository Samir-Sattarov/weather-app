import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../features/auth/data/datasources/authentication_local_data_source.dart';
import 'api_constants.dart';
import 'api_exceptions.dart';



class ApiClient  {
  final AuthenticationLocalDataSource _authenticationLocalDataSource;
  final Client _client;

  ApiClient(this._client, this._authenticationLocalDataSource);

  @override
  Future<dynamic> get(String path, {Map<dynamic, dynamic>? params}) async {
    String sessionId =
        await _authenticationLocalDataSource.getSessionId() ?? "";

    final pth = getPath(path, params);

    print("Pth $pth");

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


  @override
  Future<dynamic> post(String path,
      {Map<dynamic, dynamic>? params, bool withToken = true, bool withBaseUrl = true, bool isFirebase = false}) async {
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
      log("Session != null $sessionId");
      userHeader.addAll({'Authorization': 'Bearer $sessionId'});
    }

    final uri = Uri.parse(withBaseUrl ?  ApiConstants.baseApiUrl + path :  path);


    final response = await _client.post(
      uri,
      body: jsonEncode(params),
      headers: userHeader,
    );
    if (kDebugMode) {
      log("Post uri = $uri");
      log("Post header = $userHeader");
      log("Post body =  ${jsonEncode(params)}");
      print("API post response: ${response.statusCode} ");
      print(utf8.decode(response.bodyBytes));
    }




    if (response.statusCode == 400 ||
        response.statusCode == 403 ||
        response.statusCode == 405) {
      String msg = "unknown_error";
      Map<String,dynamic> resp = jsonDecode(utf8.decode(response.bodyBytes));

      print("Resp $resp");
      if (resp.containsKey("error")) {
        if(isFirebase){
          msg = resp["error"]['message'];

        }else {
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

      print("Expetion with message");
      throw ExceptionWithMessage(msg);
    }
    if (response.statusCode == 401  ) {
      throw UnauthorisedException();
    } else if (response.statusCode == 404) {
      throw const ExceptionWithMessage("Not found");
    } if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Everyt thing ok");
      return json.decode(utf8.decode(response.bodyBytes));
    }else {
      print("Exception ${response.reasonPhrase}");
      throw Exception(response.reasonPhrase);
    }
  }

  // @override
  // Future<dynamic> put(String path, {Map<dynamic, dynamic>? params}) async {
  //   String sessionId =
  //       await _authenticationLocalDataSource.getSessionId() ?? "";
  //   Map<String, String> userHeader = {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //
  //   if (sessionId != '') {
  //     userHeader.addAll({'Authorization': 'Bearer $sessionId'});
  //   }
  //   final response = await _client.put(
  //     getPath(path, null),
  //     body: jsonEncode(params),
  //     headers: userHeader,
  //   );
  //   if (kDebugMode) {
  //     print(utf8.decode(response.bodyBytes));
  //   }
  //
  //   print("Response $path ${response.statusCode}");
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     // print("Everyt thing ok");
  //     return json.decode(utf8.decode(response.bodyBytes));
  //   }
  //   if (response.statusCode == 400 ||
  //       response.statusCode == 403 ||
  //       response.statusCode == 405) {
  //     String msg = "unknown_error";
  //     var resp = jsonDecode(utf8.decode(response.bodyBytes));
  //     if (resp.containsKey("error")) {
  //       msg = resp["error"];
  //     } else if (resp.containsKey("message")) {
  //       var rsp = resp["message"];
  //       if (rsp.runtimeType == String) msg = resp["message"];
  //       if (rsp.runtimeType == List) msg = rsp[0];
  //     } else {
  //       msg = utf8
  //           .decode(response.bodyBytes)
  //           .replaceAll("[", '')
  //           .replaceAll("]", '')
  //           .replaceAll("}", '')
  //           .replaceAll("{", '')
  //           .replaceAll("\\", '');
  //     }
  //     throw ExceptionWithMessage(msg);
  //   } else if (response.statusCode == 401) {
  //     throw UnauthorisedException();
  //   } else if (response.statusCode == 404) {
  //     throw const ExceptionWithMessage("Not found");
  //   } else {
  //     print("Exception ${response.reasonPhrase}");
  //     throw Exception(response.reasonPhrase);
  //   }
  // }
  //
  // dynamic deleteWithBody(String path, {Map<dynamic, dynamic>? params}) async {
  //   String sessionId =
  //       (await _authenticationLocalDataSource.getSessionId()) ?? "";
  //   final response = await _client.delete(
  //     //getPath(path, null),
  //     Uri.parse('${ApiConstants.baseApiUrl}$path'),
  //
  //     headers: {
  //       'Authorization': 'Bearer $sessionId',
  //       // 'Content-Type': 'application/json',
  //     },
  //   );
  //
  //   // print("API delete response code: ${response.statusCode} ");
  //   // print(utf8.decode(response.bodyBytes));
  //   if (response.statusCode == 204) {
  //     return {'success': true};
  //   } else if (response.statusCode == 200) {
  //     return {'success': true};
  //   } else if (response.statusCode == 400 ||
  //       response.statusCode == 403 ||
  //       response.statusCode == 402 ||
  //       response.statusCode == 405) {
  //     String msg = "unknown_error";
  //     var resp = jsonDecode(utf8.decode(response.bodyBytes));
  //     if (resp.containsKey("error")) {
  //       msg = resp["error"];
  //     } else if (resp.containsKey("message")) {
  //       var rsp = resp["message"];
  //       if (rsp.runtimeType == String) msg = resp["message"];
  //       if (rsp.runtimeType == List) msg = rsp[0];
  //     } else {
  //       msg = utf8
  //           .decode(response.bodyBytes)
  //           .replaceAll("[", '')
  //           .replaceAll("]", '')
  //           .replaceAll("}", '')
  //           .replaceAll("{", '')
  //           .replaceAll("\\", '');
  //     }
  //     throw ExceptionWithMessage(msg);
  //   } else if (response.statusCode == 401) {
  //     throw UnauthorisedException();
  //   } else {
  //     throw Exception(response.reasonPhrase);
  //   }
  // }

  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = '';
    if (params?.isNotEmpty ?? false) {
      params?.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }

    return Uri.parse('${ApiConstants.baseApiUrl}$path$paramsString');
    // '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}$paramsString');
  }
}
