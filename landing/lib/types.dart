import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

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
}

LocalStorage storage = LocalStorage('kolab_landing');

class Pallet {
  // static Color background = Color(0xFF161819);
  // static Color font1 = Color(0xFFf9f9fb);
  // static Color font2 = Color(0xFFececed);
  // static Color font3 = Color(0xFFbebebe);
  // static Color inner1 = Color(0xFF323337);
  // static Color inner2 = Color(0xFF27292D);
  // static Color inner3 = Color(0xFF1d1f20);

  static bool light = false;

  static Color background = Color(0xFF161819);
  static Color insideFont = Colors.white;

  static Color font1 = Color(0xFFf9f9fb);
  static Color font2 = Color(0xFFececed);
  static Color font3 = Color(0xFFbebebe);

  static Color inner1 = Color(0xFF323337);
  static Color inner2 = Color(0xFF27292D);
  static Color inner3 = Color(0xFF1d1f20);
  static darkMode() {
    Pallet.background = Color(0xFF161819);
    Pallet.insideFont = Colors.white;

    Pallet.font1 = Color(0xFFf9f9fb);
    Pallet.font2 = Color(0xFFececed);
    Pallet.font3 = Color(0xFFbebebe);

    Pallet.inner1 = Color(0xFF323337);
    Pallet.inner2 = Color(0xFF27292D);
    Pallet.inner3 = Color(0xFF1d1f20);
  }

  static lightMode() {
    Pallet.background = Color(0xFFf5f7fb);
    Pallet.insideFont = Colors.white;

    Pallet.font1 = Color(0xFF464646);
    Pallet.font2 = Color(0xFF5c5c5c);
    Pallet.font3 = Color(0xFFa2a2a2);

    Pallet.inner1 = Color(0xFFffffff);
    Pallet.inner2 = Color(0xFFe3e3e5);
    Pallet.inner3 = Color(0xFFf5f7fb);
  }
}
