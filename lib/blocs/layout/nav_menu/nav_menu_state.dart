import 'package:equatable/equatable.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';

class NavMenuState extends Equatable {
  final String? selectedRouteName;

  const NavMenuState({
    required this.selectedRouteName,
  });

  const NavMenuState.empty() : selectedRouteName = null;

  bool pathEquals(NavItemModel navItemModel) {
    return selectedRouteName == navItemModel.pageRouteInfo?.routeName;
  }

  @override
  List<Object?> get props => <Object?>[selectedRouteName];
}
