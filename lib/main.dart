import 'package:flutter/material.dart';
import 'package:km_test/pages/home_pages.dart';
import 'package:km_test/pages/second_page.dart';
import 'package:km_test/pages/third_page.dart';
import 'package:km_test/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => UserProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: false,
        ),
        routes: {
          '/': (context) => const HomePage(),
          '/second': (context) => const SecondPage(),
          '/third': (context) => const ThirdPage(),
        });
  }
}
