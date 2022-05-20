import 'package:bloc_rest/home/custom_nav_bar.dart';
import 'package:bloc_rest/services/connectivity_services.dart';
import 'package:bloc_rest/services/knowello_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => KnowelloService()),
          RepositoryProvider(create: (context) => ConnectivityServices()),
        ],
        child: const CustomBottomNavigationBar(),
      ),
    );
  }
}
