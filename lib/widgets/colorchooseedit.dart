import 'package:flutter/material.dart';
import 'package:mynotepad/constant/constant.dart';
import 'package:mynotepad/controller/notecontroller/notecontroller.dart';
import 'package:provider/provider.dart';

class ColorChooseedit extends StatefulWidget {
  const ColorChooseedit({super.key});

  @override
  State<ColorChooseedit> createState() => _ColorChooseeditState();
}

class _ColorChooseeditState extends State<ColorChooseedit> {
  @override
  Widget build(BuildContext context) {
    Notecontroller provider =Provider.of<Notecontroller>(context,listen: false);
    return 
               Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 38, 37, 37),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.keyboard_arrow_down,color: Constant.textcolor,)),

                    Expanded(
                      child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Constant.mycolor.length,
                      itemBuilder: (context,index){
                        return
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            provider.changeappbar();
                            index==0?
                            provider.editcolor(Colors.black.value):
                             provider.editcolor(Constant.mycolor[index].value);
                            },
                          child: Consumer<Notecontroller>(
                            builder: (context,values,child)=>
                             Container(
                              child: index==0 ? Icon(Icons.not_interested):
                              null,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Constant.mycolor[index],
                                  border:values.notecolor.value==Constant.mycolor[index].value||(values.notecolor.value==Colors.black.value&&index==0)?
                                   Border.all(color: Colors.amber,width: 6):
                                   null
                              ),
                            ),
                          ),
                        ),
                      );
                      }
                      ),
                    )
                  ],
                ),
               );
  }
}