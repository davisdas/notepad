import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mynotepad/constant/constant.dart';
import 'package:mynotepad/model/notemodel/notemodel.dart';



class Notecontroller extends ChangeNotifier{




// search 
List searchlist =[];

void search(var value){
  searchlist.clear();
  if(value.isEmpty){
     searchlist.clear();
     notifyListeners();
  }
for(int i=0; i<notelist.length;i++){
  var title =notelist[i].title.toLowerCase();
  var des =notelist[i].description.toLowerCase();
  var query = value.trim().toLowerCase();
  if(title.contains(query)|| des.contains(query)){
    searchlist.add(i);
   
  }
  
}
notifyListeners();
}

bool appbarchange = false; 

void changeappbar(){
appbarchange = true;
notifyListeners();
}
void changeappbarnormal(){
appbarchange = false;
notifyListeners();
}

////// editing functions

  // color functions

  Color notecolor = Colors.black;

  void selectcolor(int index){
    index==100?
    notecolor = Colors.black:
    notecolor = Constant.mycolor[index];
    notifyListeners();
  }
  
  // edit color

   var descriptioncolor; 
   void getcolor(int index){
     descriptioncolor =  notelist[index].colorvalue;
   }

   void editcolor(int colorvalue){
    descriptioncolor = colorvalue;
    notifyListeners();
   }


// edit note title and description

  List<NoteModel> get newList => notelist;

  void editnote(int index ,var newtitle , var newdescription , var newcolorvalue, var day) {
    List<NoteModel> updatedList = notelist
        .asMap()
        .map((i, item) => i == index
            ? MapEntry(i, NoteModel(title: newtitle,description: newdescription, colorvalue: newcolorvalue, timeday: day,))
            : MapEntry(i, item))
        .values
        .toList();

    notelist = updatedList;
    updatedb();
    notifyListeners();
  }

 

//  hive functions


  List<NoteModel> notelist=[];
  var db =Hive.box("note");

  void adddata( {required title, required description, required color ,required timeday ,}){
    notelist.add(NoteModel(title: title.toString(), description: description.toString(), colorvalue: color.value, timeday: timeday ));
    updatedb();
    notifyListeners();
  }



  void loaddb()async{
   List newlist = db.get('Notelist');
  notelist = newlist.map((e) =>
                NoteModel(
                  title: e.title, 
                  description: e.description, 
                  colorvalue: e.colorvalue, timeday: e.timeday,
                  )
                  ).toList();
  }

  void deletedb(int index){
    notelist.removeAt(index);
    updatedb();
    notifyListeners();
  }

  void updatedb(){
    db.put('Notelist', notelist);
    notifyListeners();
  }
  



    }
                   



