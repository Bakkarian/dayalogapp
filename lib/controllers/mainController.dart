
import 'package:get/get.dart';

import '../modals/DarkThemeProvider.dart';
import '../styles/styles.dart';

class mainController extends GetxController{

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void onInit(){
    super.onInit();
  }


  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

}