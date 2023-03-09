import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

class StarButton extends StatefulWidget {
  final void Function(bool value) onChanged;
  final bool value;
  final double size;

  const StarButton({
    required this.onChanged,
    this.value = false,
    this.size = 18,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StarButton();
}

class _StarButton extends State<StarButton> {
  late bool selected;

  @override
  void initState() {
    super.initState();
    selected = widget.value;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selected = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          selected = !selected;
        });
        widget.onChanged(selected);
      },
      child: _getHeartIcon(),
    );
  }

  Widget _getHeartIcon() {
    if (selected) {
      return Icon(
        AppIcons.star,
        color: DesignColors.white1,
        size: widget.size,
      );
    }
    return Icon(
      AppIcons.star_outlined,
      color: DesignColors.accent,
      size: widget.size,
    );
  }
}
