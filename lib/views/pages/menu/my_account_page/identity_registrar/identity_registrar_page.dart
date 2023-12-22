import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/identity_registrar/a_identity_registrar_state.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/blocs/generic/identity_registrar/states/identity_registrar_loaded_state.dart';
import 'package:miro/blocs/generic/identity_registrar/states/identity_registrar_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_field_config_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_field_type.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_custom_entry_button.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/desktop/ir_record_tile_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/ir_record_tile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/last_block_time_widget.dart';

class IdentityRegistrarPage extends StatefulWidget {
  final WalletAddress walletAddress;

  const IdentityRegistrarPage({
    required this.walletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IdentityRegistrarPage();
}

class _IdentityRegistrarPage extends State<IdentityRegistrarPage> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final IdentityRegistrarCubit identityRegistrarCubit = globalLocator<IdentityRegistrarCubit>();

    return SliverToBoxAdapter(
      child: BlocBuilder<IdentityRegistrarCubit, AIdentityRegistrarState>(
        bloc: identityRegistrarCubit,
        builder: (BuildContext context, AIdentityRegistrarState identityRegistrarState) {
          IRModel? irModel = identityRegistrarState.irModel;
          bool infoButtonVisibleBool = irModel != null && irModel.isEmpty() == false;
          bool loadingBool = identityRegistrarState is IdentityRegistrarLoadingState;

          return Column(
            children: <Widget>[
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomLeft,
                child: LastBlockTimeWidget(
                  blockTime: identityRegistrarState is IdentityRegistrarLoadedState ? identityRegistrarState.blockDateTime : null,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ResponsiveWidget.isLargeScreen(context) ? DesignColors.black : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    if (ResponsiveWidget.isLargeScreen(context))
                      IRRecordTileDesktopLayout(
                        infoButtonVisibleBool: infoButtonVisibleBool,
                        height: 53,
                        infoButtonWidget: const SizedBox(),
                        recordWidget: Text(S.of(context).irEntries, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
                        statusWidget: Text(S.of(context).irRecordStatus, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
                        buttonWidget: const SizedBox(),
                      ),
                    IRRecordTile(
                      infoButtonVisibleBool: infoButtonVisibleBool,
                      identityRegistrarCubit: identityRegistrarCubit,
                      loadingBool: loadingBool,
                      irRecordModel: irModel?.avatarIRRecordModel,
                      irRecordFieldConfigModel: IRRecordFieldConfigModel(
                        label: S.of(context).irAvatar,
                        irRecordFieldType: IRRecordFieldType.text,
                      ),
                    ),
                    IRRecordTile(
                      infoButtonVisibleBool: infoButtonVisibleBool,
                      identityRegistrarCubit: identityRegistrarCubit,
                      loadingBool: loadingBool,
                      irRecordModel: irModel?.usernameIRRecordModel,
                      irRecordFieldConfigModel: IRRecordFieldConfigModel(
                        label: S.of(context).irUsername,
                        irRecordFieldType: IRRecordFieldType.text,
                        valueMaxLength: 32,
                      ),
                    ),
                    IRRecordTile(
                      infoButtonVisibleBool: infoButtonVisibleBool,
                      identityRegistrarCubit: identityRegistrarCubit,
                      loadingBool: loadingBool,
                      irRecordModel: irModel?.descriptionIRRecordModel,
                      irRecordFieldConfigModel: IRRecordFieldConfigModel(
                        label: S.of(context).irDescription,
                        irRecordFieldType: IRRecordFieldType.text,
                      ),
                    ),
                    IRRecordTile(
                      infoButtonVisibleBool: infoButtonVisibleBool,
                      identityRegistrarCubit: identityRegistrarCubit,
                      loadingBool: loadingBool,
                      irRecordModel: irModel?.socialMediaIRRecordModel,
                      irRecordFieldConfigModel: IRRecordFieldConfigModel(
                        label: S.of(context).irSocialMedia,
                        irRecordFieldType: IRRecordFieldType.urls,
                      ),
                    ),
                    ...?irModel?.otherIRRecordModelList.map((IRRecordModel irRecordModel) {
                      return IRRecordTile(
                        infoButtonVisibleBool: infoButtonVisibleBool,
                        identityRegistrarCubit: identityRegistrarCubit,
                        loadingBool: loadingBool,
                        irRecordModel: irRecordModel,
                        irRecordFieldConfigModel: IRRecordFieldConfigModel(
                          label: irRecordModel.key,
                          irRecordFieldType: IRRecordFieldType.text,
                        ),
                      );
                    }).toList(),
                    IRCustomEntryButton(onTap: () => _pressCustomEntryButton(identityRegistrarCubit)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _pressCustomEntryButton(IdentityRegistrarCubit identityRegistrarCubit) async {
    await KiraRouter.of(context).push<void>(TransactionsWrapperRoute(
      children: <PageRouteInfo>[
        IRTxRegisterRecordRoute(irRecordModel: null, irKeyEditableBool: true),
      ],
    ));
    await identityRegistrarCubit.refresh();
  }
}
