import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/employees.dart';

import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Employees>(create: (ctx) => Employees())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zylu Business App',
        theme: ThemeData(
            primarySwatch: Colors.teal, accentColor: Colors.tealAccent),
        home: const HomeScreen(),
      ),
    );
  }
}
