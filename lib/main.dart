import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vimigo_technical_interview/screens/attendant_record/attendant_record.dart';
import 'package:vimigo_technical_interview/screens/on_boarding/screen_one.dart';
import 'package:vimigo_technical_interview/screens/on_boarding/screen_three.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDescending = prefs.getBool("descendingOrder")!;
      isChangeFormat = prefs.getBool("changeFormat")!;
      skip = prefs.getBool("skip")!;
      next = prefs.getBool("next")!;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          skip == true || next == true ? const AttendantRecord() : ScreenOne(),
    );
  }
}
