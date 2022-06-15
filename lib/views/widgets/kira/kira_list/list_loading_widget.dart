import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class ListLoadingWidget extends StatelessWidget {
  const ListLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        CenterLoadSpinner(),
      ],
    );
  }
}
