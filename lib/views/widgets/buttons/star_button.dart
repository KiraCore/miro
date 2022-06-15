import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class StarButton extends StatefulWidget {
  final bool value;
  final void Function(bool value) onChanged;
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
    selected = widget.value;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    selected = widget.value;
    super.didChangeDependencies();
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
        Icons.star,
        color: DesignColors.yellow_100,
        size: widget.size,
      );
    }
    return Icon(
      Icons.star_border,
      color: DesignColors.gray2_100,
      size: widget.size,
    );
  }
}
