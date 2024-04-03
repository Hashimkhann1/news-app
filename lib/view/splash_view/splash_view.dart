import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/view_model/splash_view_model/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  final SplashViewModel splashViewModel = SplashViewModel();

  void initState() {
    // TODO: implement initState
    super.initState();
    splashViewModel.splashTimer(context);

  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/splash_pic.jpg',
            fit: BoxFit.cover,
            height: height * .5,
          ),
          SizedBox(height: height * 0.04,),
          Text("Top Headlines" , style: GoogleFonts.anton(color: Colors.grey.shade700,letterSpacing: .6,fontSize: 17),),
          SizedBox(height: height * 0.04,),
          SpinKitChasingDots(
            color: Colors.blue,
            size: 41,
          )
        ],
      )),
    );
  }
}
