import 'package:flutter/material.dart';
import 'package:mvvm_flutter/userlist/presentation/view/HomeScreen.dart';
import 'package:mvvm_flutter/userlist/presentation/viewmodel/UserViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserViewModel())],
      child: MaterialApp(
        title: 'User List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
