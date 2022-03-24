import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrettyInput extends StatelessWidget {
  final String? leadingText;
  final Widget? child;
  final bool disabled;
  final Color? color;

  const PrettyInput({
    this.child,
    this.color,
    this.disabled = false,
    this.leadingText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.4 : 1,
      child: Container(
        width: double.infinity,
        height: 62,
        decoration: BoxDecoration(
          color: color,
          // border: Border.all(
          //   color: const Color(0xFFEBEBEB),
          //   width: 1,
          // ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          child: Row(
            children: <Widget>[
              if (leadingText != null) ...<Widget>[
                SizedBox(width: 36, height: 36, child: Text(leadingText!)),
                const SizedBox(width: 15),
              ],
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme: const InputDecorationTheme(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 15),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      floatingLabelStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  child: SizedBox(
                    height: 36,
                    width: double.infinity,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
