import 'package:flutter/cupertino.dart';

class ListNoResultsWidget extends StatelessWidget {
  final double? minHeight;

  const ListNoResultsWidget({
    this.minHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: minHeight,
      child: const Center(
        child: Text('No results'),
      ),
    );
  }
}
