import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String url;

  @HiveField(3)
  int price;

  @HiveField(4)
  int stock_quantity;

  NotesModel({
    required this.id,
    required this.name,
    required this.url,
    required this.price,
    required this.stock_quantity,
  });
}
