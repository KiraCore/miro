import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

class NavItem {
  final PageRouteInfo? pageRouteInfo;
  final bool enabled;
  final String name;
  final IconData icon;

  bool get isEnabled {
    return enabled && pageRouteInfo != null;
  }

  const NavItem({
    required this.pageRouteInfo,
    required this.name,
    required this.icon,
    this.enabled = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NavItem && runtimeType == other.runtimeType && pageRouteInfo == other.pageRouteInfo;

  @override
  int get hashCode => pageRouteInfo.hashCode;
}
