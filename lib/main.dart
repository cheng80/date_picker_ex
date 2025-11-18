//main.dart
import 'package:date_picker_ex/apple_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';


//import 'package:프로젝트명/home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Main',
      // 다국어 지원
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 영어
        const Locale('ko', 'KR'), // 한국어
        const Locale('ja', 'JP'), // 일본어
      ],
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
      debugShowCheckedModeBanner: false, // 우측 상단 디버그 배너 제거
   

      initialRoute: '/appleDatePicker',
      
      getPages: [
        GetPage(name: '/appleDatePicker', page: () => AppleDatePicker()),
      ],
      
    );
  }
}