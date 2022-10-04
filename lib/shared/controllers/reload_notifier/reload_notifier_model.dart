import 'package:flutter/widgets.dart';

class ReloadNotifierModel extends ChangeNotifier {
  void reload() {
    notifyListeners();
  }
}
