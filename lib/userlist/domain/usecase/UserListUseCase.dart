import 'package:mvvm_flutter/userlist/common/usecase/BaseUseCase.dart';
import 'package:mvvm_flutter/userlist/domain/repo/UserServicesRepo.dart';

class UserListUseCase extends BaseUseCase<Object> {
  final UserServicesRepo _userServicesRepo;

  UserListUseCase({required UserServicesRepo userServicesRepo})
      : _userServicesRepo = userServicesRepo;
  @override
  Future<Object> perform() async {
    return _userServicesRepo.getUsers();
  }
}
