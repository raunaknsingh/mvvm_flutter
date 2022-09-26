import 'package:flutter/material.dart';
import 'package:mvvm_flutter/userlist/model/UserError.dart';
import 'package:mvvm_flutter/userlist/model/UserListModel.dart';
import 'package:mvvm_flutter/userlist/repo/ApiStatus.dart';
import 'package:mvvm_flutter/userlist/repo/UserServices.dart';

class UserViewModel extends ChangeNotifier {
  bool _loading = false;
  List<UserItemModel> _userListModel = [];
  UserError? _userError;

  bool get loading => _loading;
  List<UserItemModel> get userListModel => _userListModel;
  UserError? get userError => _userError;

  UserViewModel() {
    getUsers();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserListModel(List<UserItemModel> userListModel) {
    _userListModel = userListModel;
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  getUsers() async {
    setLoading(true);
    var response = await UserServices.getusers();
    if (response is Success) {
      setUserListModel(response.response as List<UserItemModel>);
    }
    if (response is Failure) {
      UserError userError =
          UserError(code: response.code, errorResponse: response.errorResponse);
      setUserError(userError);
    }
    setLoading(false);
  }
}
