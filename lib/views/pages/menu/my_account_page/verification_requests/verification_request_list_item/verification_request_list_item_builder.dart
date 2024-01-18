import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/ir_verification_request_drawer_page/ir_verification_request_drawer_page.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_request_list_item/desktop/verification_request_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/verification_requests/verification_request_list_item/mobile/verification_request_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class VerificationRequestListItemBuilder extends StatefulWidget {
  final IRInboundVerificationRequestModel irInboundVerificationRequestModel;

  const VerificationRequestListItemBuilder({
    required this.irInboundVerificationRequestModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerificationRequestListItemBuilder();
}

class _VerificationRequestListItemBuilder extends State<VerificationRequestListItemBuilder> {
  @override
  Widget build(BuildContext context) {
    Widget desktopListItem = VerificationRequestListItemDesktop(
      onApproveButtonPressed: _pressApproveButton,
      onRejectButtonPressed: _pressRejectButton,
      onShowDrawerPressed: _pressShowDrawerButton,
      irInboundVerificationRequestModel: widget.irInboundVerificationRequestModel,
    );

    Widget mobileListItem = VerificationRequestListItemMobile(
      onApproveButtonPressed: _pressApproveButton,
      onRejectButtonPressed: _pressRejectButton,
      onShowDrawerPressed: _pressShowDrawerButton,
      irInboundVerificationRequestModel: widget.irInboundVerificationRequestModel,
    );

    return ResponsiveWidget(
      largeScreen: desktopListItem,
      mediumScreen: mobileListItem,
      smallScreen: mobileListItem,
    );
  }

  void _pressApproveButton() {
    _openTransactionPage(approvalStatusBool: true, context: context);
  }

  void _pressRejectButton() {
    _openTransactionPage(approvalStatusBool: false, context: context);
  }

  Future<void> _openTransactionPage({required bool approvalStatusBool, required BuildContext context}) async {
    await KiraRouter.of(context).push<void>(TransactionsWrapperRoute(
      children: <PageRouteInfo>[
        IRTxHandleVerificationRequestRoute(
          approvalStatusBool: approvalStatusBool,
          irInboundVerificationRequestModel: widget.irInboundVerificationRequestModel,
        ),
      ],
    ));

    BlocProvider.of<InfinityListBloc<IRInboundVerificationRequestModel>>(context).add(const ListReloadEvent(forceRequestBool: true));
  }

  void _pressShowDrawerButton() {
    KiraScaffold.of(context).navigateEndDrawerRoute(
      IRVerificationRequestDrawerPage(
        irInboundVerificationRequestModel: widget.irInboundVerificationRequestModel,
        listBloc: BlocProvider.of<InfinityListBloc<IRInboundVerificationRequestModel>>(context),
      ),
    );
  }
}
