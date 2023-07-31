import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/desktop/ir_record_tile_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/mobile/ir_record_tile_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';

class IRRecordTile extends StatefulWidget {
  final bool loadingBool;
  final Widget valueWidget;
  final IdentityRegistrarCubit identityRegistrarCubit;
  final IRRecordModel? irRecordModel;

  const IRRecordTile({
    required this.loadingBool,
    required this.valueWidget,
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
    return ResponsiveValue<Widget>(
      largeScreen: IRRecordTileDesktop(
        loadingBool: widget.loadingBool,
        valueWidget: widget.valueWidget,
        identityRegistrarCubit: widget.identityRegistrarCubit,
        irRecordModel: widget.irRecordModel,
      ),
      smallScreen: IRRecordTileMobile(
        loadingBool: widget.loadingBool,
        valueWidget: widget.valueWidget,
        identityRegistrarCubit: widget.identityRegistrarCubit,
        irRecordModel: widget.irRecordModel,
      ),
    ).get(context);
  }
}
