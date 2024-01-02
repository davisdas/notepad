import 'package:hive/hive.dart';
part 'notemodel.g.dart';


@HiveType(typeId: 1)
class NoteModel {

  @HiveField(0)
   final String title;

   @HiveField(1)
   final String description;

   @HiveField(2)
   final int colorvalue;

  

  NoteModel( {required this.title, required this.description, required this.colorvalue ,});
}

