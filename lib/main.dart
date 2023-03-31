import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:widget_sandbox/screens/dropdown_menu_demo.dart';
import 'package:widget_sandbox/screens/materialyou_searchbar_demo.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      useInheritedMediaQuery: true,
      routes: {
        '/': (context) => const HomeScreen(),
        DropdownMenuDemo.routeName: (context) => const DropdownMenuDemo(),
        MaterialyouSearchbarDemo.routeName: (context) =>
            const MaterialyouSearchbarDemo(),
      },
      initialRoute: '/',
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Widget Sandbox'),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: const Text('Dropdown Menu Demo'),
              onTap: () {
                Navigator.pushNamed(context, DropdownMenuDemo.routeName);
              },
            ),
            ListTile(
              title: const Text('Material You Searchbar Demo'),
              onTap: () {
                Navigator.pushNamed(
                    context, MaterialyouSearchbarDemo.routeName);
              },
            ),
          ],
        ));
  }
}
