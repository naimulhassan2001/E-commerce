import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'model/note_model.dart';
import 'package:path_provider/path_provider.dart';

import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationCacheDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('database');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blue,
            titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23))
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
