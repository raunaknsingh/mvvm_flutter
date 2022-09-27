import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mvvm_flutter/userlist/domain/repo/UserServicesRepo.dart';
import 'package:mvvm_flutter/userlist/utils/Constants.dart';

import '../model/UserListModel.dart';
import '../../common/repo/ApiStatus.dart';

class UserServicesRepoImpl implements UserServicesRepo {
  @override
  Future<Object> getUsers() async {
    try {
      var url = Uri.parse(USERS_LIST);
      var response = await http.get(url);
      if (SUCCESS == response.statusCode) {
        return Success(
            code: response.statusCode,
            response: userListModelFromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown error ');
    }
  }
}
