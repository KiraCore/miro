import 'package:flutter/material.dart';
import 'package:miro/views/layout/nav_menu/model/tile_decoration.dart';

class NavTileThemeData {
  final TileDecoration enabledTileDecoration;
  final TileDecoration? enabledHoverTileDecoration;
  final TileDecoration activeTileDecoration;
  final TileDecoration? activeHoverTileDecoration;
  final TileDecoration disabledTileDecoration;
  final TileDecoration? disabledHoverTileDecoration;

  NavTileThemeData({
    required this.enabledTileDecoration,
    required this.activeTileDecoration,
    required this.disabledTileDecoration,
    this.enabledHoverTileDecoration,
    this.activeHoverTileDecoration,
    this.disabledHoverTileDecoration,
  });

  TileDecoration? getTileTheme(Set<MaterialState> tileState) {
    if( tileState.contains(MaterialState.hovered) ) {
     return _onHoverTheme(tileState);
    }
    if( tileState.contains(MaterialState.disabled)) {
      return disabledTileDecoration;
    }
    if (tileState.contains(MaterialState.selected)) {
      return activeTileDecoration;
    }
    return enabledTileDecoration;
  }

  TileDecoration? _onHoverTheme(Set<MaterialState> tileState) {
    if( tileState.contains(MaterialState.disabled)) {
      return disabledHoverTileDecoration ?? disabledTileDecoration;
    }
    if (tileState.contains(MaterialState.selected)) {
      return activeHoverTileDecoration ?? enabledHoverTileDecoration;
    }
    return enabledHoverTileDecoration ?? activeTileDecoration;
  }


  Color? getBackgroundColor(Set<MaterialState> tileState) {
    return getTileTheme(tileState)?.backgroundColor;
  }

  Color? getFontColor(Set<MaterialState> tileState) {
    return getTileTheme(tileState)?.fontColor;
  }

  Color? getIconColor(Set<MaterialState> tileState) {
    TileDecoration? tileDecoration = getTileTheme(tileState);
    return tileDecoration?.iconColor ?? tileDecoration?.fontColor;
  }
}
