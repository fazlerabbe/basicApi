import 'package:flutter/material.dart';

import 'homepage.dart';
import 'http_example/delete_request.dart';
import 'http_example/get_request.dart';
import 'http_example/post_request.dart';
import 'http_example/put_request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeleteData(),
    );
  }
}
