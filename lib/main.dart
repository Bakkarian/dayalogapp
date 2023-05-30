import 'package:dayalog/authentications/Login.dart';
import 'package:dayalog/controllers/mainController.dart';
import 'package:dayalog/pages/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'modals/DarkThemeProvider.dart';
import 'pages/Launcher/Launcher.dart';
import 'styles/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final mainController _mainController = Get.put(mainController());

  @override
  void initState() {
    super.initState();
    _mainController.getCurrentAppTheme();
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) {
          return _mainController.themeChangeProvider;
        },
        child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return GetMaterialApp(
            title: 'Dayalog',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(_mainController.themeChangeProvider.darkTheme, context),
            getPages: [
              GetPage(name: '/launcher', page: () => const Launcher()),
              GetPage(name: '/mainPage', page: () => const MainPage()),
            ],
            home: const Launcher(),
          );
        }));

  }
}