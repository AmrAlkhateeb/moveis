import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:move/views/home_screen.dart';

  void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      ProviderScope(
      child:  MyApp()
  )
  );
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       backgroundColor: Colors.black
      ),
      home: AnimatedSplashScreen(
        splash:Center(
          child:Container(
              height:double.infinity ,
              width:double.infinity ,
              child: Image.asset('assets/images/6ec722db-fe29-4cd8-aa62-2860b3ed2ed9.jpg',
                fit:BoxFit.cover,)),

        ),
        nextScreen: HomeScreen(),
        splashIconSize:double.infinity ,
        splashTransition: SplashTransition.fadeTransition,

        duration:1000 ,
      ),
    );
  }
}


