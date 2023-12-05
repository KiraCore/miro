import 'package:flutter/material.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegation_list_item/desktop/undelegation_list_item_destkop.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegation_list_item/mobile/undelegation_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class UndelegationListItemBuilder extends StatefulWidget {
  final UndelegationModel undelegationModel;

  const UndelegationListItemBuilder({
    required this.undelegationModel,
    Key? key,
  }) : super(key: key);

  @override
  State<UndelegationListItemBuilder> createState() => _UndelegationListItemBuilderState();
}

class _UndelegationListItemBuilderState extends State<UndelegationListItemBuilder> {
  @override
  Widget build(BuildContext context) {
    Widget desktopListItem = UndelegationListItemDesktop(
      undelegationModel: widget.undelegationModel,
    );

    Widget mobileListItem = UndelegationListItemMobile(
      undelegationModel: widget.undelegationModel,
    );

    return ResponsiveWidget(
      largeScreen: desktopListItem,
      mediumScreen: mobileListItem,
      smallScreen: mobileListItem,
    );
  }
}
