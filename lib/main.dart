import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'pages/home/ui/home.dart';
import '../constants/color.dart';
import 'services/database.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.grey.shade200,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.white,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'id_ID';
  await db.init();
  runApp(DotApp());
}

class DotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF0A97B0, AppColor.material),
        fontFamily: 'SourceSansPro',
      ),
      home: DotHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
