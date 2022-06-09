import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/controllable_expansion_tile.dart';

class KiraExpansionTileController extends ChangeNotifier {
  final GlobalKey<ControllableExpansionTileState> expansionTileGlobalKey = GlobalKey();

  KiraExpansionTileController();

  void expand() {
    expansionTileGlobalKey.currentState?.expand();
    notifyExpansionChanged();
  }

  void collapse() {
    expansionTileGlobalKey.currentState?.collapse();
    notifyExpansionChanged();
  }

  void toggle() {
    expansionTileGlobalKey.currentState?.toggle();
    notifyExpansionChanged();
  }

  void notifyExpansionChanged() {
    notifyListeners();
  }
}
