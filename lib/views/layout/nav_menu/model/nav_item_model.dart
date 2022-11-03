import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class NavItemModel extends Equatable {
  final bool disabled;
  final String name;
  final PageRouteInfo? pageRouteInfo;
  final IconData icon;

  const NavItemModel({
    required this.name,
    required this.pageRouteInfo,
    required this.icon,
    this.disabled = false,
  });

  @override
  List<Object?> get props => <Object?>[disabled, name, pageRouteInfo, icon];
}
