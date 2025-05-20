import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'api/asset_api.dart';
import 'bloc/asset/asset_bloc.dart';
import 'bloc/asset/asset_event.dart';
import 'repository/asset_repository.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Security',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => AssetBloc(
          repository: AssetRepositoryImpl(
            remoteDataSource: AssetRemoteDataSource(
              client: http.Client(),
            ),
          ),
        )..add(LoadAssetEvent()),
        child: const HomeScreen(),
      ),
    );
  }
}
