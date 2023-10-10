import 'package:equatable/equatable.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';

class NavMenuState extends Equatable {
  final String? selectedPath;

  const NavMenuState({
    required this.selectedPath,
  });

  const NavMenuState.empty() : selectedPath = null;

  bool pathEquals(NavItemModel navItemModel) {
    return selectedPath == navItemModel.pageRouteInfo?.fragment;
  }

  @override
  List<Object?> get props => <Object?>[selectedPath];
}
