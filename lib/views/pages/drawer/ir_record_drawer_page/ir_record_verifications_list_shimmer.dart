import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/loading_container.dart';

class IRRecordVerificationsListShimmer extends StatelessWidget {
  const IRRecordVerificationsListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return const ListTile(
          dense: false,
          contentPadding: EdgeInsets.zero,
          leading: ClipOval(
            child: LoadingContainer(
              height: 30,
              width: 30,
            ),
          ),
          title: LoadingContainer(
            height: 16,
            width: 100,
            circularBorderRadius: 5,
          ),
          trailing: LoadingContainer(
            height: 16,
            width: 100,
            circularBorderRadius: 5,
          ),
        );
      },
    );
  }
}
