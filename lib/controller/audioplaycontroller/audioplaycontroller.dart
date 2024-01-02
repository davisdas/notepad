import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Audioplaycontroller with ChangeNotifier , WidgetsBindingObserver{


FlutterTts flutterTts = FlutterTts();
  String lastText = ""; 
  bool isPaused = false; 
  bool startplaying =false;

  reset(){
    startplaying =false;
    notifyListeners();
  }

  speak(String title ,String text) async {
    startplaying = true;
    isPaused = false;

    lastText = text; 
    await flutterTts.setLanguage("en-Uk");
    await flutterTts.setPitch(0.9);
    await flutterTts.setSpeechRate(0.38); 
    await flutterTts.speak(title);
    await Future.delayed(Duration(milliseconds: 1500));
    await flutterTts.speak(text);
    await flutterTts.setVolume(1);
   
    notifyListeners();
  }

  pause() async {
    await flutterTts.pause();
    isPaused = true;
    notifyListeners();
  }

  stop() async {
    await flutterTts.stop();
    startplaying = false;
    notifyListeners();
  }

  resume() async {
      await flutterTts.speak(lastText);
      isPaused = false;
      notifyListeners();
  }
  
  Audioplaycontroller() {
    WidgetsBinding.instance.addObserver(this);
  }


   @override
   void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      pause(); 
    }}

}