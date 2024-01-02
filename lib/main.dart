import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mynotepad/controller/audioplaycontroller/audioplaycontroller.dart';
import 'package:mynotepad/controller/notecontroller/notecontroller.dart';
import 'package:mynotepad/controller/settingscontroller/settingscontroller.dart';
import 'package:mynotepad/model/notemodel/notemodel.dart';
import 'package:mynotepad/view/splashscreen/splashscreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<NoteModel>(NoteModelAdapter());
  await Hive.openBox('note');
  await Hive.openBox('Settings');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
      ChangeNotifierProvider(create: (context)=>Settingscontroller()),
      ChangeNotifierProvider(create:(context)=>Notecontroller(),),
      ChangeNotifierProvider(create:(context)=>Audioplaycontroller(),)
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // textTheme: GoogleFonts.josefinSansTextTheme(),
          // textTheme: GoogleFonts.sevillanaTextTheme(),
        ),
        home: SplashScreen(
        ),
      ),
     );
     
  }
}


