import 'dart:io';

import 'package:http/http.dart';
import 'package:netflix_clone/utils/constats.dart';

import 'http_petition_data.dart';

abstract class HttpProvider {
  String get httpUrl;
  PetitionType get petitionType;

  Future<String> getJsonResponse({
    HttpPetitionData? petitionData,
    required String? token,
    Map<String, dynamic>? queryParams,
  }) async {
    switch (petitionType) {
      case PetitionType.POST:
        assert(petitionData != null);
        break;
      case PetitionType.GET:
      case PetitionType.UPDATE:
      case PetitionType.DELETE:
        break;
      case PetitionType.PUT:
        assert(petitionData != null);
        break;
    }
    final uri = _getUri(params: queryParams);

    switch (petitionType) {
      case PetitionType.GET:
        return _getJsonResponseGetWithToken(uri, token!);

      case PetitionType.POST:
        if (token != null) {
          return _getJsonResponsePostWithToken(uri, petitionData!, token);
        } else {
          return _getJsonResponsePostWithOutToken(uri, petitionData!);
        }
      case PetitionType.UPDATE:
        return _getJsonResponseUpdateWithToken(uri, petitionData, token!);
      case PetitionType.DELETE:
        if (petitionData == null) {
          return _getJsonResponseDeleteWithTokenWithoutPetitionData(
              uri, token!);
        } else {
          return _getJsonResponseDeleteWithTokenWithPetitionData(
              uri, petitionData, token!);
        }
      case PetitionType.PUT:
        return _getJsonResponsePutWithToken(uri, petitionData!, token!);
    }
  }

  Future<String> _getJsonResponseGetWithToken(Uri uri, String token) async {
    final Response _response =
        await get(uri, headers: _getHeaderWithToken(token));
    if (_response.statusCode == 200) {
      return _response.body;
    } else {
      throw Exception(
          'network error. \n Code: ${_response.statusCode} \n Body: ${_response.body}');
    }
  }

  Future<String> _getJsonResponsePostWithToken(
      Uri uri, HttpPetitionData petitionData, String token) async {
    final Response _response = await post(uri,
        headers: _getHeaderWithToken(token), body: petitionData.toJson());
    if (_response.statusCode == 200) {
      return _response.body;
    } else {
      throw Exception(
          'network error. \n Code: ${_response.statusCode} \n Body: ${_response.body}');
    }
  }

  Future<String> _getJsonResponsePostWithOutToken(
      Uri uri, HttpPetitionData petitionData) async {
    final body = petitionData.toJson();
    final Response _response = await post(uri, body: body);
    if (_response.statusCode == 200) {
      return _response.body;
    } else {
      throw Exception(
          'network error. \n Code: ${_response.statusCode} \n Body: ${_response.body}');
    }
  }

  Future<String> _getJsonResponseDeleteWithTokenWithPetitionData(
      Uri uri, HttpPetitionData petitionData, String token) async {
    final Response _response = await delete(uri,
        headers: _getHeaderWithToken(token), body: petitionData.toJson());
    if (_response.statusCode == 200) {
      return _response.body;
    } else {
      throw Exception(
          'network error. \n Code: ${_response.statusCode} \n Body: ${_response.body}');
    }
  }

  Future<String> _getJsonResponseDeleteWithTokenWithoutPetitionData(
      Uri uri, String token) async {
    final Response _response =
        await delete(uri, headers: _getHeaderWithToken(token));
    if (_response.statusCode == 200) {
      return _response.body;
    } else {
      throw Exception(
          'network error. \n Code: ${_response.statusCode} \n Body: ${_response.body}');
    }
  }

  Future<String> _getJsonResponsePutWithToken(
      Uri uri, HttpPetitionData petitionData, String token) async {
    final Response _response = await put(uri,
        headers: _getHeaderWithToken(token), body: petitionData.toJson());
    if (_response.statusCode == 200) {
      return _response.body;
    } else {
      throw Exception(
          'network error. \n Code: ${_response.statusCode} \n Body: ${_response.body}');
    }
  }

  Future<String> _getJsonResponseUpdateWithToken(
      Uri uri, HttpPetitionData? petitionData, String token) async {
    final Response _response = await put(uri,
        headers: _getHeaderWithToken(token), body: petitionData?.toJson());
    if (_response.statusCode == 200) {
      return _response.body;
    } else {
      throw Exception(
          'network error. \n Code: ${_response.statusCode} \n Body: ${_response.body}');
    }
  }

  Map<String, String> _getHeaderWithToken(String token) {
    return <String, String>{
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  Uri _getUri({Map<String, dynamic>? params}) {
    if (params != null) {
      return Uri.http(httpBaseUrl, httpUrl, params);
    } else {
      return Uri.http(httpBaseUrl, httpUrl);
    }
  }
}

enum PetitionType { GET, POST, DELETE, UPDATE, PUT }
