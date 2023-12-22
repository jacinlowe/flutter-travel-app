import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'features/trip/data/models/trip_model.dart';

import 'features/trip/presentation/pages/main_screen.dart';

void main() async {
  //initialize hive and open our box
  WidgetsFlutterBinding.ensureInitialized();
  String os = Platform.operatingSystem;
  // Get the save directory for hive

  final Directory path = await getApplicationDocumentsDirectory();

  await Hive.initFlutter(path.path);
  Hive.registerAdapter(TripModelAdapter());
  await Hive.openBox<TripModel>('trips');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Travel App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainScreen());
  }
}
