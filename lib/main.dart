import 'package:aria_client/views/art/list_view.dart';
import 'package:aria_client/views/test/test_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'test',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ArtListView(),
      initialRoute: '/',
      getPages: [
        GetPage(name: "/", page: () => TestPage()),
      ],
    );
  }
}
