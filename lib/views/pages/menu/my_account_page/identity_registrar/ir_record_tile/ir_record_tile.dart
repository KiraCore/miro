import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/desktop/ir_record_tile_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/mobile/ir_record_tile_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';

class IRRecordTile extends StatefulWidget {
  final bool loadingBool;
  final bool irKeyEditableBool;
  final Widget valueWidget;
  final IdentityRegistrarCubit identityRegistrarCubit;
  final IRRecordModel? irRecordModel;
  final int? valueMaxLength;

  const IRRecordTile({
    required this.loadingBool,
    required this.irKeyEditableBool,
    required this.valueWidget,
    required this.identityRegistrarCubit,
    required this.irRecordModel,
    this.valueMaxLength,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IdentityRecordTile();
}

class _IdentityRecordTile extends State<IRRecordTile> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveValue<Widget>(
      largeScreen: IRRecordTileDesktop(
        loadingBool: widget.loadingBool,
        valueWidget: widget.valueWidget,
        onAddPressed: _openRegisterRecordRoute,
        onDeletePressed: _pressDeleteButton,
        onEditPressed: _openRegisterRecordRoute,
        onVerifyPressed: _pressVerifyButton,
        identityRegistrarCubit: widget.identityRegistrarCubit,
        irRecordModel: widget.irRecordModel,
      ),
      smallScreen: IRRecordTileMobile(
        loadingBool: widget.loadingBool,
        valueWidget: widget.valueWidget,
        onAddPressed: _openRegisterRecordRoute,
        onDeletePressed: _pressDeleteButton,
        onEditPressed: _openRegisterRecordRoute,
        onVerifyPressed: _pressVerifyButton,
        identityRegistrarCubit: widget.identityRegistrarCubit,
        irRecordModel: widget.irRecordModel,
      ),
    ).get(context);
  }

  Future<void> _openRegisterRecordRoute() async {
    await KiraRouter.of(context).push<void>(PagesWrapperRoute(
      children: <PageRouteInfo>[
        TransactionsWrapperRoute(children: <PageRouteInfo>[
          IRTxRegisterRecordRoute(
            irRecordModel: widget.irRecordModel,
            irKeyEditableBool: widget.irKeyEditableBool,
            irValueMaxLength: widget.valueMaxLength,
          ),
        ]),
      ],
    ));
    await widget.identityRegistrarCubit.refresh();
  }

  Future<void> _pressDeleteButton() async {
    if (widget.irRecordModel == null) {
      return;
    }
    await KiraRouter.of(context).push<void>(PagesWrapperRoute(
      children: <PageRouteInfo>[
        TransactionsWrapperRoute(children: <PageRouteInfo>[
          IRTxDeleteRecordRoute(irRecordModel: widget.irRecordModel!),
        ]),
      ],
    ));
    await widget.identityRegistrarCubit.refresh();
  }

  Future<void> _pressVerifyButton() async {
    await KiraRouter.of(context).push<void>(PagesWrapperRoute(
      children: <PageRouteInfo>[
        TransactionsWrapperRoute(children: <PageRouteInfo>[
          IRTxRequestVerificationRoute(irRecordModel: widget.irRecordModel!),
        ]),
      ],
    ));
    await widget.identityRegistrarCubit.refresh();
  }
}
