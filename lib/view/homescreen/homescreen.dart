import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mynotepad/constant/constant.dart';
import 'package:mynotepad/controller/notecontroller/notecontroller.dart';
import 'package:mynotepad/controller/settingscontroller/settingscontroller.dart';
import 'package:mynotepad/view/descriptionscreen/descriptionadd.dart';
import 'package:mynotepad/view/searchscreen/searchscreen.dart';
import 'package:mynotepad/widgets/drawer.dart';
import 'package:mynotepad/widgets/note.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? formattedTime;

Future getCurrentTime() async {
   var now = DateTime.now();
     var formatter = DateFormat('MMM dd');
    formattedTime = formatter.format(now);
  
  
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {

       Provider.of<Settingscontroller>(context, listen: false).loadsettings(); 
     Provider.of<Notecontroller>(context, listen: false).loaddb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int revindex;

    Settingscontroller settingprovider =Provider.of<Settingscontroller>(context);
    return Scaffold(

     endDrawer: Drawerhome(),

      backgroundColor: Constant.primarycolor,
      body:Builder(builder: (BuildContext context) {
        return 
        
         CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 80,
            title: Text(
              "NotePad",
              style: TextStyle(color: Constant.textcolor, fontSize: settingprovider.titlefont),
            ),
            centerTitle: true,
            // expandedHeight: 100,
            floating: false,
            pinned: true,
            backgroundColor: Constant.primarycolor,
            
            leading: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen())),
              child: Icon(Icons.search_rounded ,color: Constant.textcolor,
                size: settingprovider.titlefont+5,)),
    
          

            actions: [
             IconButton(onPressed: ()=>
              Scaffold.of(context).openEndDrawer(),
             icon: Icon(Icons.settings),
                color: Constant.textcolor,
                iconSize: settingprovider.titlefont+5,
                )
            ],
          ),

          

          // body
          Consumer<Notecontroller>(
            builder: (context, values, child) 
            
            { return SliverToBoxAdapter(
              child: SizedBox(
                child: 
                 values.notelist.isEmpty?
                 Padding(
                   padding:  EdgeInsets.only(top: 150),
                   child: SizedBox(
                    height: 200,width: 200,
                    child: LottieBuilder.asset("assets/Animation - 1702618201972.json")),
                 )
                 :
                MasonryGridView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: settingprovider.rowcount,
                    ),
                    itemCount: values.notelist.length,
                    itemBuilder: (context, index) {
                      settingprovider.latest == true
                          ? revindex = values.notelist.length - index - 1
                          : revindex = index;
                          
                      return 
                      Padding(
                        padding: const EdgeInsets.all(6.5),
                        child: Note(
                          index: revindex,
                        ),
                      );

                      
                    }),
              ),
            );
      }
          )
        ],
      );
      }),
      
     
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentTime();
    
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DescriptionAdd(
                        time: formattedTime,
                      )));
        },
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
    );
  }
}
