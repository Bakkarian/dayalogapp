
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobilePage;
  final Widget tabletPage;
  final Widget desktopPage;

  ResponsiveLayout({required this.desktopPage, required this.tabletPage, required this.mobilePage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      if(constraints.maxWidth < 600){
        return mobilePage;
      }else if(constraints.maxWidth < 960){
        return tabletPage;
      }else{
        return desktopPage;
      }
    });
  }
}
