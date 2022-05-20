import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tb_logistics_app/pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('credentialBox');
  runApp(const TbLogisticsApp());
}

class TbLogisticsApp extends StatelessWidget {
  const TbLogisticsApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tb Transportes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade800,
      ),
      home: const HomePage(title: 'Tb Transportes'),
    );
  }
}
