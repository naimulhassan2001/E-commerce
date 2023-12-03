import 'package:demo_alor_feri/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'model/note_model.dart';
import 'package:path_provider/path_provider.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationCacheDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('database') ;
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInPage(),
    );
  }
}
