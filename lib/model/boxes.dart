

import 'package:hive/hive.dart';

import 'note_model.dart';

class Boxes  {
  static Box<NotesModel> getData()  => Hive.box('database') ;
}
