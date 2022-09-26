import 'package:flutter/material.dart';
import 'package:mvvm_flutter/userlist/model/UserListModel.dart';
import 'package:mvvm_flutter/userlist/viewmodel/UserViewModel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _ui(userViewModel),
          ],
        ),
      ),
    );
  }

  _ui(UserViewModel userViewModel) {
    if (userViewModel.loading) {
      return Container();
    }
    if (userViewModel.userError != null) {
      return Container();
    }
    return Expanded(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          UserItemModel userItemModel = userViewModel.userListModel[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                userItemModel.name ?? '',
                style: const TextStyle(color: Colors.black),
              ),
              Text(userItemModel.email ?? '',
                  style: const TextStyle(color: Colors.black)),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: userViewModel.userListModel.length,
      ),
    );
  }
}
