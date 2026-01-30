import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

enum AppTheme { glassDark, glassLight, classicLight, classicDark }

StreamController<String> refresh = StreamController<String>.broadcast();
StreamSink<String> get refreshSink => refresh.sink;
Stream<String> get refreshStream => refresh.stream;

StreamController<String> animation = StreamController<String>.broadcast();
StreamSink<String> get animationSink => animation.sink;
Stream<String> get animationStream => animation.stream;

StreamController<String> event = StreamController<String>.broadcast();
StreamSink<String> get eventSink => event.sink;
Stream<String> get eventStream => event.stream;

StreamController<String> router = StreamController<String>.broadcast();
StreamSink<String> get routerSink => router.sink;
Stream<String> get routerStream => router.stream;

StreamController<String> request = StreamController<String>.broadcast();
StreamSink<String> get requestSink => request.sink;
Stream<String> get requestStream => request.stream;

StreamController<AppTheme> themeChange = StreamController<AppTheme>.broadcast();
StreamSink<AppTheme> get themeChangeSink => themeChange.sink;
Stream<AppTheme> get themeChangeStream => themeChange.stream;

class Event {
  String name;
  Function func;
  Event({required this.name, required this.func});
}

class Events {
  List<Event> registeredEvents = [];
  registerEvent(eventName, func) {
    bool exists = false;
    for (var event in registeredEvents) {
      if (event.name == eventName) {
        exists = true;
      }
    }
    if (!exists) {
      print("registered " + eventName);
      registeredEvents.add(Event(name: eventName, func: func));
    }
  }

  Events() {
    animationStream.listen((eventName) async {
      for (var event in registeredEvents) {
        if (event.name == eventName) {
          print("playing " + event.name);
          event.func();
        }
      }
    });
  }
}

Events events = Events();

class Window {
  // screen
  static double width = 0;
  static double fullWidth = 0;

  static double height = 0;
  static double fullHeight = 0;

  static double stageWidth = 0;
  static String mode = "none";

  static ValueNotifier<bool> siderBarOpen = ValueNotifier<bool>(true);

  // static bool siderBarOpen = true;
  static bool closeOnExit = false;
  static double sideBarWidth = 320;

  static ValueNotifier<String> page = ValueNotifier<String>("none");
  fullScreen() {}

  static bool get isMobile => fullWidth < 800;
}

LocalStorage storage = LocalStorage('kolab_landing');

class Pallet {
  static bool light = true;

  static Color background = const Color(0xFFFAFAFA);
  static Color insideFont = const Color(0xFF1F2937);

  static Color font1 = const Color(0xFF1F2937);
  static Color font2 = const Color(0xFF4B5563);
  static Color font3 = const Color(0xFF6B7280);

  static Color inner1 = Colors.black.withOpacity(0.05);
  static Color inner2 = Colors.black.withOpacity(0.08);
  static Color inner3 = Colors.black.withOpacity(0.1);

  static darkMode() {
    Pallet.light = false;
    Pallet.background = const Color(0xFF161819);
    Pallet.insideFont = Colors.white;

    Pallet.font1 = const Color(0xFFe6e8ed);
    Pallet.font2 = const Color(0xFFc9ccd3);
    Pallet.font3 = const Color(0xFF728b99);

    Pallet.inner1 = Colors.white.withOpacity(0.1);
    Pallet.inner2 = Colors.white.withOpacity(0.15);
    Pallet.inner3 = Colors.white.withOpacity(0.2);
  }

  static lightMode() {
    Pallet.light = true;
    Pallet.background = const Color(0xFFFAFAFA);
    Pallet.insideFont = const Color(0xFF1F2937);

    Pallet.font1 = const Color(0xFF1F2937);
    Pallet.font2 = const Color(0xFF4B5563);
    Pallet.font3 = const Color(0xFF6B7280);

    Pallet.inner1 = Colors.black.withOpacity(0.05);
    Pallet.inner2 = Colors.black.withOpacity(0.08);
    Pallet.inner3 = Colors.black.withOpacity(0.1);
  }
}

class DemoPallet {
  static AppTheme currentTheme = AppTheme.glassDark;

  static Color background = const Color(0xFF161819);
  static Color insideFont = Colors.white;

  static Color font1 = const Color(0xFFe6e8ed);
  static Color font2 = const Color(0xFFc9ccd3);
  static Color font3 = const Color(0xFF728b99);

  static Color inner1 = Colors.white.withOpacity(0.1);
  static Color inner2 = Colors.white.withOpacity(0.15);
  static Color inner3 = Colors.white.withOpacity(0.2);

  static bool isGlass = true;
  static String fontFamily = 'Poppins';

  static void setTheme(AppTheme theme) {
    currentTheme = theme;
    switch (theme) {
      case AppTheme.glassDark:
        Pallet.darkMode();
        background = const Color(0xFF161819);
        insideFont = Pallet.insideFont;
        font1 = Pallet.font1;
        font2 = Pallet.font2;
        font3 = Pallet.font3;
        inner1 = Pallet.inner1;
        inner2 = const Color(0xFF27292D).withOpacity(0.5);
        inner3 = Pallet.inner3;
        isGlass = true;
        fontFamily = 'Poppins';
        break;
      case AppTheme.glassLight:
        Pallet.lightMode();
        background = Pallet.background;
        insideFont = Pallet.insideFont;
        font1 = Pallet.font1;
        font2 = Pallet.font2;
        font3 = Pallet.font3;
        inner1 = Pallet.inner1;
        inner2 = const Color(0xFFe3e3e5).withOpacity(0.5);
        inner3 = Pallet.inner3;
        isGlass = true;
        fontFamily = 'Poppins';
        break;
      case AppTheme.classicLight:
        Pallet.lightMode();
        background = Pallet.background;
        insideFont = Pallet.insideFont;
        font1 = Pallet.font1;
        font2 = Pallet.font2;
        font3 = Pallet.font3;
        inner1 = Pallet.inner1;
        inner2 = const Color(0xFFf0f0f0);
        inner3 = Pallet.inner3;
        isGlass = false;
        fontFamily = 'Inter';
        break;
      case AppTheme.classicDark:
        Pallet.darkMode();
        background = Pallet.background;
        insideFont = Pallet.insideFont;
        font1 = Pallet.font1;
        font2 = Pallet.font2;
        font3 = Pallet.font3;
        inner1 = Pallet.inner1;
        inner2 = const Color(0xFF3D3D3D);
        inner3 = Pallet.inner3;
        isGlass = false;
        fontFamily = 'Ubuntu';
        break;
    }
    themeChangeSink.add(theme);
  }

  static void darkMode() => setTheme(AppTheme.glassDark);
  static void lightMode() => setTheme(AppTheme.glassLight);

  static bool get light =>
      currentTheme == AppTheme.glassLight || currentTheme == AppTheme.classicLight;
}
