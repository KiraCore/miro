import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/identity_registrar/a_identity_registrar_state.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/blocs/pages/metamask/metamask_integration_provider.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list_tile.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/generic/account/account_header.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/generic/responsive/desktop_expanded.dart';
import 'package:miro/views/widgets/generic/responsive/screen_size.dart';
import 'package:miro/views/widgets/generic/responsive/sized_box_expanded.dart';
import 'package:provider/provider.dart';

class MyAccountPageHeader extends StatelessWidget {
  final Wallet wallet;

  const MyAccountPageHeader({
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PopWrapperController popWrapperController = PopWrapperController();

    return ColumnRowSwapper(
      children: <Widget>[
        DesktopExpanded(
          child: BlocBuilder<IdentityRegistrarCubit, AIdentityRegistrarState>(
            bloc: globalLocator<IdentityRegistrarCubit>(),
            builder: (BuildContext context, AIdentityRegistrarState identityRegistrarState) {
              return AccountHeader(irModel: identityRegistrarState.irModel);
            },
          ),
        ),
        const ColumnRowSpacer(size: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Consumer<MetaMaskProvider>(
              builder: (BuildContext context, MetaMaskProvider provider, Widget? child) {
                return SizedBoxExpanded(
                  width: 137,
                  expandOn: const <ScreenSize>[
                    ScreenSize.mobile,
                    ScreenSize.tablet,
                  ],
                  child: PopWrapper(
                    popWrapperController: popWrapperController,
                    popupBuilder: () {
                      return ChangeNotifierProvider<MetaMaskProvider>.value(
                        value: context.read<MetaMaskProvider>(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const AccountMenuListTile(
                                onTap: null,
                                title: 'Pay with MIRO',
                              ),
                              AccountMenuListTile(
                                onTap: () {
                                  popWrapperController.hideTooltip();

                                  _payWithMetamask(context);
                                },
                                title: 'Pay with MetaMask',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    buttonBuilder: () {
                      return KiraElevatedButton(
                        onPressed: () {
                          if (context.read<MetaMaskProvider>().isConnected) {
                            return popWrapperController.showTooltip();
                          }
                        },
                        disabled: !context.read<MetaMaskProvider>().isConnected,
                        title: S.of(context).balancesButtonPay,
                        icon: Transform.rotate(
                          angle: -pi / 2,
                          child: const Icon(
                            AppIcons.arrow_up_right,
                            size: 20,
                            color: DesignColors.background,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            SizedBoxExpanded(
              width: 118,
              expandOn: const <ScreenSize>[
                ScreenSize.mobile,
                ScreenSize.tablet,
              ],
              child: KiraElevatedButton(
                onPressed: null,
                disabled: true,
                title: S.of(context).balancesButtonRequest,
                icon: Transform.rotate(
                  angle: pi / 2,
                  child: const Icon(
                    AppIcons.arrow_up_right,
                    size: 20,
                    color: DesignColors.background,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _payWithMetamask(BuildContext context) {
    context.read<MetaMaskProvider>().pay();
  }
}
