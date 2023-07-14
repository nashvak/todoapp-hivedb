import 'package:hive/hive.dart';
part 'models.g.dart';

@HiveType(typeId: 1)
class NotesModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  final bool isCompleted;
  NotesModel({required this.title, required this.isCompleted, this.id});
}
