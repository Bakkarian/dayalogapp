import 'package:dayalog/pages/home/desktopHomePage.dart';
import 'package:dayalog/pages/home/mobileHomePage.dart';
import 'package:dayalog/pages/home/tabletHomePage.dart';
import 'package:dayalog/pages/responsive/desktopPage.dart';
import 'package:dayalog/pages/responsive/mobilePage.dart';
import 'package:dayalog/pages/responsive/responsive_layout.dart';
import 'package:dayalog/pages/responsive/tabletPage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        desktopPage: desktopPage(page: const desktopHomePage(),),
        tabletPage: tabletPage(page: const mobileHomePage(),),
        mobilePage: mobilePage(page: const mobileHomePage(),));
  }
}
