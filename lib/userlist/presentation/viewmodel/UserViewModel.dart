import 'package:flutter/material.dart';

import '../../common/model/UserError.dart';
import '../../common/repo/ApiStatus.dart';
import '../../data/model/UserListModel.dart';
import '../../data/repo/UserServicesRepoImpl.dart';
import '../../domain/usecase/UserListUseCase.dart';

class UserViewModel extends ChangeNotifier {
  bool _loading = false;
  List<UserItemModel> _userListModel = [];
  UserError? _userError;

  bool get loading => _loading;
  List<UserItemModel> get userListModel => _userListModel;
  UserError? get userError => _userError;

  UserListUseCase userListUseCase =
      UserListUseCase(userServicesRepo: UserServicesRepoImpl());

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
    var response = await userListUseCase.perform();
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
