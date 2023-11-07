import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_field_config_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_field_type.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/ir_record_drawer_page/ir_record_drawer_page.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/desktop/ir_record_tile_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/mobile/ir_record_tile_mobile.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_value_widget/ir_record_text_value_widget.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_value_widget/ir_record_urls_value_widget.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class IRRecordTile extends StatefulWidget {
  final bool infoButtonVisibleBool;
  final bool loadingBool;
  final IRRecordFieldConfigModel irRecordFieldConfigModel;
  final IdentityRegistrarCubit identityRegistrarCubit;
  final IRRecordModel? irRecordModel;

  const IRRecordTile({
    required this.infoButtonVisibleBool,
    required this.loadingBool,
    required this.irRecordFieldConfigModel,
    required this.identityRegistrarCubit,
    required this.irRecordModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IdentityRecordTile();
}

class _IdentityRecordTile extends State<IRRecordTile> {
  @override
  Widget build(BuildContext context) {
    late Widget valueWidget;

    if (widget.irRecordFieldConfigModel.irRecordFieldType == IRRecordFieldType.urls) {
      valueWidget = IRRecordUrlsValueWidget(
        loadingBool: widget.loadingBool,
        label: widget.irRecordFieldConfigModel.label,
        urls: widget.irRecordModel?.value?.split(',').toList() ?? <String>[],
      );
    } else {
      valueWidget = IRRecordTextValueWidget(
        expandableBool: false,
        maxLines: 6,
        loadingBool: widget.loadingBool,
        label: widget.irRecordFieldConfigModel.label,
        value: widget.irRecordModel?.value,
      );
    }

    return ResponsiveWidget(
      largeScreen: IRRecordTileDesktop(
        infoButtonVisibleBool: widget.infoButtonVisibleBool,
        loadingBool: widget.loadingBool,
        valueWidget: valueWidget,
        onAddPressed: _openRegisterRecordRoute,
        onDeletePressed: _pressDeleteButton,
        onEditPressed: _openRegisterRecordRoute,
        onVerifyPressed: _pressVerifyButton,
        onShowDrawerPressed: _openDetailsDrawer,
        identityRegistrarCubit: widget.identityRegistrarCubit,
        irRecordModel: widget.irRecordModel,
      ),
      mediumScreen: IRRecordTileMobile(
        loadingBool: widget.loadingBool,
        valueWidget: valueWidget,
        onAddPressed: _openRegisterRecordRoute,
        onDeletePressed: _pressDeleteButton,
        onEditPressed: _openRegisterRecordRoute,
        onVerifyPressed: _pressVerifyButton,
        onShowDrawerPressed: _openDetailsDrawer,
        identityRegistrarCubit: widget.identityRegistrarCubit,
        irRecordModel: widget.irRecordModel,
      ),
    );
  }

  Future<void> _openRegisterRecordRoute() async {
    await KiraRouter.of(context).push<void>(TransactionsWrapperRoute(
      children: <PageRouteInfo>[
        IRTxRegisterRecordRoute(
          irRecordModel: widget.irRecordModel,
          irKeyEditableBool: widget.irRecordModel?.key.isNotEmpty == true,
          irValueMaxLength: widget.irRecordFieldConfigModel.valueMaxLength,
        )
      ],
    ));
    await widget.identityRegistrarCubit.refresh();
  }

  Future<void> _pressDeleteButton() async {
    if (widget.irRecordModel == null) {
      return;
    }
    await KiraRouter.of(context).push<void>(TransactionsWrapperRoute(
      children: <PageRouteInfo>[
        IRTxDeleteRecordRoute(irRecordModel: widget.irRecordModel!),
      ],
    ));
    await widget.identityRegistrarCubit.refresh();
  }

  Future<void> _pressVerifyButton() async {
    await KiraRouter.of(context).push<void>(TransactionsWrapperRoute(
      children: <PageRouteInfo>[
        IRTxRequestVerificationRoute(irRecordModel: widget.irRecordModel!),
      ],
    ));
    await widget.identityRegistrarCubit.refresh();
  }

  Future<void> _openDetailsDrawer() async {
    if (widget.irRecordModel == null) {
      return;
    }
    KiraScaffold.of(context).navigateEndDrawerRoute(IRRecordDrawerPage(
      identityRegistrarCubit: widget.identityRegistrarCubit,
      irRecordModel: widget.irRecordModel!,
      irRecordFieldConfigModel: widget.irRecordFieldConfigModel,
    ));
  }
}
