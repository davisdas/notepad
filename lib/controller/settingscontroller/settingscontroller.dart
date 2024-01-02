import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Settingscontroller extends ChangeNotifier {
  ///// setting functions

  var hivesettings = Hive.box("note");

  // theme setting

//  grid view and list view
  int rowcount = 2;
  double ratio = 1.8;
  bool selectgrid = true;
  bool selectlist = false;

  void chooselist() {
    rowcount = 1;
    selectgrid = false;
    selectlist = true;
    notifyListeners();
    hivesettings.put('view', 'list');
  }

  void choosegrid() {
    rowcount = 2;
    selectgrid = true;
    selectlist = false;
    notifyListeners();
    hivesettings.put('view', 'grid');
  }

//  sorting

  bool latest = true;

  void sortlatest() {
    latest = true;
    notifyListeners();
    hivesettings.put('latest', true);
  }

  void sortoldset() {
    latest = false;
    notifyListeners();
    hivesettings.put('latest', false);
  }

// font size
  double titlefont = 22;
  double descriptionfont = 16;

  bool small = false;
  bool medium = true;
  bool large = false;

  void smallfont() {
    small = true;
    medium = false;
    large = false;
    titlefont = 18;
    descriptionfont = 12;
    notifyListeners();
    hivesettings.put('fontsize', 'small');
  }

  void mediumfont() {
    small = false;
    medium = true;
    large = false;
    titlefont = 22.5;
    descriptionfont = 16;
    notifyListeners();
    hivesettings.put('fontsize', 'medium');
  }

  void largefont() {
    small = false;
    medium = false;
    large = true;
    titlefont = 26;
    descriptionfont = 20;
    notifyListeners();
    hivesettings.put('fontsize', 'large');
  }

  void loadsettings() {
    var hivefont = hivesettings.get('fontsize');
    if (hivefont == 'small') {
      smallfont();
    } else if (hivefont == 'medium') {
      mediumfont();
    } else if (hivefont == 'large') {
      largefont();
    }

    var hivelatest = hivesettings.get('latest');
    if (hivelatest == true) {
      sortlatest();
    } else if (hivelatest == false) {
      sortoldset();
    }

    var hiveview = hivesettings.get("view");
    if (hiveview == 'grid') {
      choosegrid();
    } else if (hiveview == 'list') {
      chooselist();
    }
  }
}
