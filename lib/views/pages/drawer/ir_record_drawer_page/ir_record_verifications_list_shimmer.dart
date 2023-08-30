import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:shimmer/shimmer.dart';

class IRRecordVerificationsListShimmer extends StatelessWidget {

  const IRRecordVerificationsListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          dense: false,
          contentPadding: EdgeInsets.zero,
          leading: ClipOval(
            child: Shimmer.fromColors(
              baseColor: DesignColors.grey3,
              highlightColor: DesignColors.grey2,
              child: Container(
                width: 30,
                height: 30,
                color: DesignColors.grey2,
              ),
            ),
          ),
          title: Shimmer.fromColors(
            baseColor: DesignColors.grey3,
            highlightColor: DesignColors.grey2,
            child: Container(
              width: 100,
              height: 16,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: DesignColors.grey2,
              ),
            ),
          ),
          trailing: Shimmer.fromColors(
            baseColor: DesignColors.grey3,
            highlightColor: DesignColors.grey2,
            child: Container(
              width: 100,
              height: 16,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: DesignColors.grey2,
              ),
            ),
          ),
        );
      },
    );
  }
}
