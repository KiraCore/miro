import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

/// Toggle between ETH and KIRA addresses
class ToggleBetweenWalletAddressTypes extends StatelessWidget {
  const ToggleBetweenWalletAddressTypes({Key? key, this.padding}) : super(key: key);

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = globalLocator<AuthCubit>();
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: BlocBuilder<AuthCubit, Wallet?>(
        bloc: authCubit,
        // TODO(Mykyta): add buildWhen once option will be in the state
        // buildWhen: (Wallet? previous, Wallet? current) => previous.option != current.option,
        builder: (BuildContext context, Wallet? state) {
          if (authCubit.isEthereumSession == false) {
            return const SizedBox.shrink();
          }
          return InkWell(
            onTap: () {
              authCubit.toggleWalletAddress();
            },
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      Assets.arrows,
                      colorFilter: const ColorFilter.mode(DesignColors.white1, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(width: 8),
                  BlocBuilder<AuthCubit, Wallet?>(
                    bloc: authCubit,
                    buildWhen: (Wallet? previous, Wallet? current) => previous?.isEthereum != current?.isEthereum,
                    builder: (BuildContext context, Wallet? state) {
                      if (state == null) {
                        return const SizedBox(width: 24);
                      }
                      String asset = state.isEthereum ? Assets.kiraLogo : Assets.ethereumLogo;
                      return SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          asset,
                          colorFilter: const ColorFilter.mode(DesignColors.white1, BlendMode.srcIn),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
