import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/identity_registrar/a_identity_registrar_state.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/blocs/generic/identity_registrar/states/identity_registrar_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_custom_entry_button.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/desktop/ir_record_tile_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_tile/ir_record_tile.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_value_widget/ir_record_text_value_widget.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar/ir_record_value_widget/ir_record_urls_value_widget.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

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

    return BlocBuilder<IdentityRegistrarCubit, AIdentityRegistrarState>(
      bloc: identityRegistrarCubit,
      builder: (BuildContext context, AIdentityRegistrarState identityRegistrarState) {
        IRModel? irModel = identityRegistrarState.irModel;
        bool loadingBool = identityRegistrarState is IdentityRegistrarLoadingState;

        return Container(
          margin: const EdgeInsets.only(bottom: 40, top: 26),
          width: double.infinity,
          decoration: BoxDecoration(
            color: ResponsiveWidget.isSmallScreen(context) ? null : DesignColors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: <Widget>[
              if (ResponsiveWidget.isLargeScreen(context))
                IRRecordTileDesktopLayout(
                  height: 53,
                  recordWidget: Text(S.of(context).irEntries, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
                  statusWidget: Text(S.of(context).irRecordStatus, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
                  buttonWidget: const SizedBox(),
                ),
              IRRecordTile(
                irKeyEditableBool: false,
                identityRegistrarCubit: identityRegistrarCubit,
                loadingBool: loadingBool,
                valueWidget: IRRecordTextValueWidget(
                  loadingBool: loadingBool,
                  label: S.of(context).irAvatar,
                  value: irModel?.avatarIRRecordModel.value,
                ),
                irRecordModel: irModel?.avatarIRRecordModel,
              ),
              IRRecordTile(
                irKeyEditableBool: false,
                identityRegistrarCubit: identityRegistrarCubit,
                loadingBool: loadingBool,
                valueMaxLength: 32,
                valueWidget: IRRecordTextValueWidget(
                  loadingBool: loadingBool,
                  label: S.of(context).irUsername,
                  value: irModel?.usernameIRRecordModel.value,
                ),
                irRecordModel: irModel?.usernameIRRecordModel,
              ),
              IRRecordTile(
                irKeyEditableBool: false,
                identityRegistrarCubit: identityRegistrarCubit,
                loadingBool: loadingBool,
                valueWidget: IRRecordTextValueWidget(
                  loadingBool: loadingBool,
                  label: S.of(context).irDescription,
                  value: irModel?.descriptionIRRecordModel.value,
                ),
                irRecordModel: irModel?.descriptionIRRecordModel,
              ),
              IRRecordTile(
                irKeyEditableBool: false,
                identityRegistrarCubit: identityRegistrarCubit,
                loadingBool: loadingBool,
                valueWidget: IRRecordUrlsValueWidget(
                  loadingBool: loadingBool,
                  label: S.of(context).irSocialMedia,
                  urls: irModel?.socialMediaIRRecordModel.value?.split(',').toList() ?? <String>[],
                ),
                irRecordModel: identityRegistrarState.irModel?.socialMediaIRRecordModel,
              ),
              ...?irModel?.otherIRRecordModelList.map((IRRecordModel irRecordModel) {
                return IRRecordTile(
                  irKeyEditableBool: false,
                  identityRegistrarCubit: identityRegistrarCubit,
                  loadingBool: loadingBool,
                  valueWidget: IRRecordTextValueWidget(
                    loadingBool: loadingBool,
                    label: irRecordModel.key,
                    value: irRecordModel.value,
                  ),
                  irRecordModel: irRecordModel,
                );
              }).toList(),
              IRCustomEntryButton(onTap: () => _pressCustomEntryButton(identityRegistrarCubit)),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pressCustomEntryButton(IdentityRegistrarCubit identityRegistrarCubit) async {
    await KiraRouter.of(context).push<void>(PagesWrapperRoute(
      children: <PageRouteInfo>[
        TransactionsWrapperRoute(children: <PageRouteInfo>[
          IRTxRegisterRecordRoute(irRecordModel: null, irKeyEditableBool: true),
        ]),
      ],
    ));
    await identityRegistrarCubit.refresh();
  }
}
