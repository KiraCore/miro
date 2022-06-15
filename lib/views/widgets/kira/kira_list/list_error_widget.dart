import 'package:flutter/cupertino.dart';

class ListErrorWidget extends StatelessWidget {
  final String? errorMessage;

  const ListErrorWidget({
    this.errorMessage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(errorMessage ?? 'Unknown error'),
      ],
    );
  }
}
