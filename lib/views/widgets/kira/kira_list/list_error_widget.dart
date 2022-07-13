import 'package:flutter/cupertino.dart';

class ListErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final double? minHeight;

  const ListErrorWidget({
    this.errorMessage,
    this.minHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: minHeight ?? double.infinity,
      child: Center(
        child: Text(errorMessage ?? 'Unknown error'),
      ),
    );
  }
}
