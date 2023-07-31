import 'package:flutter/material.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_status_chip/ir_record_status_chip.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/desktop/ir_record_tile_desktop_layout.dart';

class IRRecordTileDesktop extends StatelessWidget {
  final bool loadingBool;
  final Widget valueWidget;
  final IdentityRegistrarCubit identityRegistrarCubit;
  final IRRecordModel? irRecordModel;

  const IRRecordTileDesktop({
    required this.loadingBool,
    required this.valueWidget,
    required this.identityRegistrarCubit,
    required this.irRecordModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IRRecordTileDesktopLayout(
      recordWidget: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: valueWidget,
      ),
      statusWidget: IRRecordStatusChip(
        loadingBool: loadingBool,
        irRecordStatus: irRecordModel?.irRecordStatus,
      ),
      buttonWidget: const SizedBox(),
    );
  }
}
