import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class DecoratedInput extends StatelessWidget {
  final Widget? leading;
  final Widget child;
  final bool disabled;
  final double? childHeight;

  const DecoratedInput({
    required this.child,
    this.disabled = false,
    this.leading,
    this.childHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.4 : 1,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 77,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: DesignColors.gray1_100,
        ),
        child: Row(
          children: <Widget>[
            if (leading != null) ...<Widget>[
              SizedBox(width: 45, height: 45, child: leading!),
              const SizedBox(width: 15),
            ],
            Expanded(
              child: Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: const InputDecorationTheme(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 2),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      floatingLabelStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 13,
                      ),
                      errorStyle: TextStyle(
                        color: DesignColors.red_100,
                        fontSize: 10,
                      ),
                      isDense: true),
                ),
                child: Container(
                  padding: childHeight == null ? const EdgeInsets.symmetric(vertical: 13) : EdgeInsets.zero,
                  height: childHeight,
                  child: Center(
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
