import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenterLoadSpinner extends StatelessWidget {
  final double? size;

  const CenterLoadSpinner({Key? key, this.size = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}