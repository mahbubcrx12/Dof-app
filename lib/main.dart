import 'package:flutter/material.dart';
import 'package:motsha_app/provider/district_provider.dart';
import 'package:motsha_app/provider/division_provider.dart';
import 'package:motsha_app/provider/notice_provider.dart';
import 'package:motsha_app/screen/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoticeProvider()),
        ChangeNotifierProvider(create: (context) => DivisionProvider()),
        ChangeNotifierProvider(create: (context)=>DistrictProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DOF',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
       //   home: SplashScreen()),
        home: SplashScreen()),
    );
  }
}
