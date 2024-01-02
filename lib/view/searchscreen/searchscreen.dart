import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mynotepad/constant/constant.dart';
import 'package:mynotepad/controller/notecontroller/notecontroller.dart';
import 'package:mynotepad/controller/settingscontroller/settingscontroller.dart';
import 'package:mynotepad/widgets/note.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
    TextEditingController searchcontroller =TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    Notecontroller provider = Provider.of<Notecontroller>(context);
    return Scaffold(
      backgroundColor: Constant.primarycolor,
      appBar: AppBar(
        backgroundColor: Constant.primarycolor,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
          provider.searchlist.clear();
        }, icon: Icon(Icons.arrow_back,color: Constant.textcolor,)),
        title:  Container(height: 45,
                    decoration: BoxDecoration(
                    color: Color.fromARGB(255, 62, 61, 61),
                    borderRadius: BorderRadius.circular(18)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, right: 10),
                      child: Center(child: 
                      TextField(
                        onChanged: (value){
                         provider.search(value);
                         
                        },
                        autofocus: true,
                        controller: searchcontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search note here"
                      ),
                      ),
                    ), 
                    ),
      ),
      ),

      body:
        provider.searchlist.isEmpty?
        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_rounded,size: 50,color: Colors.grey,),
            SizedBox(height: 10,),
            Text("No note found...",style: TextStyle(fontSize: 25,color: Colors.grey),),
          ],
        ))
        :
       MasonryGridView.builder(
        itemCount: provider.searchlist.length,
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 
        Provider.of<Settingscontroller>(context).rowcount
        ), itemBuilder: (context,index){
        return
        

         Padding(
        padding: const EdgeInsets.all(8.0),
        child: Note(index: provider.searchlist[index]),
      )
      
      ;
        }
      ),
    );
  }
}