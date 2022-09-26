import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mvvm_flutter/userlist/model/UserListModel.dart';
import 'package:mvvm_flutter/userlist/repo/ApiStatus.dart';
import 'package:mvvm_flutter/userlist/utils/Constants.dart';

class UserServices {
  static Future<Object> getusers() async {
    try {
      var url = Uri.parse(USERS_LIST);
      var response = await http.get(url);
      if (200 == response.statusCode) {
        return Success(
            code: response.statusCode,
            response: userListModelFromJson(response.body));
      }
      return Failure(
          code: response.statusCode, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown error ');
    }
  }
}
