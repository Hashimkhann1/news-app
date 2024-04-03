

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/view/home_view/home_view.dart';

class SplashViewModel {

  void splashTimer(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
    });
  }

}