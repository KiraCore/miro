import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

typedef PopWrapperButtonBuilder = Widget Function(AnimationController animationController);

class PopWrapperListItem {
  final String title;
  final GestureTapCallback onPressed;

  PopWrapperListItem({required this.title, required this.onPressed});
}

class PopWrapper extends StatefulWidget {
  final List<PopWrapperListItem> menuList;
  final PopWrapperButtonBuilder buttonBuilder;
  final double itemWidth;
  final BoxDecoration? decoration;

  const PopWrapper({
    required this.buttonBuilder,
    required this.menuList,
    this.itemWidth = 80,
    this.decoration,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopMenu();
}

class PopWrapperController extends CustomPopupMenuController {
  final AnimationController animationController;

  PopWrapperController(this.animationController);

  @override
  void showMenu() {
    menuIsShowing = true;
    animationController.forward();
    notifyListeners();
  }

  @override
  void hideMenu() {
    menuIsShowing = false;
    animationController.reverse();
    notifyListeners();
  }

  @override
  void toggleMenu() {
    if (menuIsShowing) {
      hideMenu();
    } else {
      showMenu();
    }
  }
}

class _PopMenu extends State<PopWrapper> with SingleTickerProviderStateMixin {
  late PopWrapperController popMenuController;

  @override
  void initState() {
    setUpController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: _buildDesktop(),
      mediumScreen: _buildMobile(),
    );
  }

  void setUpController() {
    AnimationController animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => setState(() {}));
    popMenuController = PopWrapperController(animationController);
  }

  Widget _buildDesktop() {
    return CustomPopupMenu(
      pressType: PressType.singleClick,
      controller: popMenuController,
      barrierColor: Colors.transparent,
      showArrow: false,
      menuBuilder: () {
        return Container(
          margin: const EdgeInsets.only(top: 15),
          width: widget.itemWidth,
          padding: const EdgeInsets.all(20),
          decoration: widget.decoration,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.menuList.length,
            itemBuilder: (BuildContext context, int index) {
              PopWrapperListItem item = widget.menuList[index];
              return MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                  onTap: () => item.onPressed(),
                  child: ListTile(
                    title: Text(
                      item.title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      child: widget.buttonBuilder(popMenuController.animationController),
    );
  }

  Widget _buildMobile() {
    return Dialog(
      backgroundColor: widget.decoration?.color,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.menuList.length,
        itemBuilder: (BuildContext context, int index) {
          PopWrapperListItem item = widget.menuList[index];
          return ListTile(
            title: Text(
              item.title,
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
