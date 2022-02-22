import 'package:flutter/cupertino.dart';

class MenuProvider extends ChangeNotifier {
  static const String defaultPath = 'dashboard';

  String currentPath = defaultPath;

  void updatePath(String path) {
    currentPath = path;
    notifyListeners();
  }
}
