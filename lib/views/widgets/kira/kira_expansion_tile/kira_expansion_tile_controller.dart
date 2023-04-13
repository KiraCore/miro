import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/controllable_expansion_tile.dart';

class KiraExpansionTileController extends ChangeNotifier {
  final GlobalKey<ControllableExpansionTileState> expansionTileGlobalKey = GlobalKey();

  KiraExpansionTileController();

  bool get isExpanded {
    return expansionTileGlobalKey.currentState?.isExpanded ?? false;
  }

  void collapse() {
    expansionTileGlobalKey.currentState?.collapse();
    notifyExpansionChanged();
  }

  void expand() {
    expansionTileGlobalKey.currentState?.expand();
    notifyExpansionChanged();
  }

  void invertVisibility() {
    expansionTileGlobalKey.currentState?.invertVisibility();
    notifyExpansionChanged();
  }

  void notifyExpansionChanged() {
    notifyListeners();
  }
}
