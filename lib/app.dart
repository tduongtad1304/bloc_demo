import 'package:flutter/material.dart';

import 'bloc_demo/views/home_page.dart';

class MyApp extends MaterialApp {
  @override
  const MyApp({Key? key})
      : super(
          key: key,
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
        );
}
