import 'package:flutter/material.dart';
import 'package:mynotepad/constant/constant.dart';
import 'package:mynotepad/controller/notecontroller/notecontroller.dart';
import 'package:mynotepad/controller/settingscontroller/settingscontroller.dart';
import 'package:mynotepad/widgets/ColorChoose.dart';
import 'package:provider/provider.dart';

class DescriptionAdd extends StatefulWidget {
  const DescriptionAdd({super.key,required this.time, });
  final time;
  @override
  State<DescriptionAdd> createState() => _DescriptionAddState();
}




class _DescriptionAddState extends State<DescriptionAdd> {
  @override
  Widget build(BuildContext context) {
    Settingscontroller settingprovider =Provider.of<Settingscontroller>(context);
    Notecontroller provider= Provider.of<Notecontroller>(context,listen: false);
    TextEditingController titlecontroller =TextEditingController();
    TextEditingController descriptioncontroller =TextEditingController();
    return Consumer<Notecontroller>(
      builder: (context,value,child)=>
       PopScope(
        canPop: false,
         child: Scaffold(
          backgroundColor: value.notecolor,
           appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(onPressed: (){
              if(titlecontroller.text.isNotEmpty||descriptioncontroller.text.isNotEmpty){
                showDialog(context: context, builder: (context)=>
                AlertDialog(
                   backgroundColor: Constant.primarycolor,
                  title: Text("Save ?",style: TextStyle(color: Colors.red),),
                  content: Text("Save and exit",style: TextStyle(color: Colors.white),),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                       Navigator.pop(context);
                    }, child: Text("Exit")),
                    TextButton(onPressed: (){
                    provider.adddata(title: titlecontroller.text, description: descriptioncontroller.text, color: value.notecolor, timeday: widget.time.toString()  );
                    value.notecolor=Colors.black;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    }, child: Text("Save"))
                  ],
                )
                );
              }
             if(titlecontroller.text.isEmpty && descriptioncontroller.text.isEmpty){
              Navigator.pop(context);
             };
              
            }, icon: Icon(Icons.arrow_back_rounded,color: Constant.textcolor,size: 30,)),
            actions: [
               
              // Choose color theme
              IconButton(onPressed: (){
                showModalBottomSheet(
                  context: context,
                   builder: (context)=>Wrap(children:[ ColorChoose()])
                   );
               
              }, icon: Icon(Icons.palette_outlined,color: Colors.white,size: 30,)),
               
               
              //  Done icon (for add new note to list)
               IconButton(onPressed: (){
                if(titlecontroller.text.isNotEmpty||descriptioncontroller.text.isNotEmpty){
                 provider.adddata(title: titlecontroller.text, description: descriptioncontroller.text, color: value.notecolor, timeday: widget.time.toString()  );
                  value.notecolor=Colors.black;
                  Navigator.pop(context);
                 
                }
                else{
                  // Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Empty note , adding failed.")));
                }
                 
               }, icon: Icon(Icons.done,color: Constant.textcolor,size: 30,)),
               SizedBox(width: 10,)
            ],
           ),
           body: Padding(
             padding: const EdgeInsets.all(15),
             child: ListView(
              children: [
                // title display
                TextFormField(
                  controller: titlecontroller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(color: Colors.white,fontSize: settingprovider.titlefont,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: InputBorder.none, 
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey[800])
                  ),
                ),
               
                Text("${widget.time}" ,style: TextStyle(color: Constant.textcolor),),
               
                //  body display
                TextFormField(
                  controller: descriptioncontroller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: TextStyle(color: Constant.textcolor,fontWeight: FontWeight.bold,height: 2.5,fontSize: settingprovider.descriptionfont),
                  decoration: InputDecoration(
                    border: InputBorder.none, 
                    hintText: "Start typing ",
                    hintStyle: TextStyle(color: Colors.grey[800])
                  ),
                )
              ],
             ),
           ),
               ),
       ),
    );
  }
}