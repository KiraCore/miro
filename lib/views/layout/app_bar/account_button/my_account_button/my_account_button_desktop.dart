import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/identity_registrar/a_identity_registrar_state.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/blocs/generic/identity_registrar/states/identity_registrar_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/account_pop_menu.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';

class MyAccountButtonDesktop extends StatefulWidget {
  final Size size;
  final Wallet wallet;

  const MyAccountButtonDesktop({
    required this.size,
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAccountButtonDesktop();
}

class _MyAccountButtonDesktop extends State<MyAccountButtonDesktop> {
  final PopWrapperController popWrapperController = PopWrapperController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: PopWrapper(
        popWrapperController: popWrapperController,
        popupBuilder: () {
          return AccountPopMenu(
            popWrapperController: popWrapperController,
            width: widget.size.width - widget.size.width * 0.25,
          );
        },
        buttonBuilder: () {
          return BlocBuilder<IdentityRegistrarCubit, AIdentityRegistrarState>(
            bloc: globalLocator<IdentityRegistrarCubit>(),
            builder: (BuildContext context, AIdentityRegistrarState identityRegistrarState) {
              IRModel? irModel = identityRegistrarState.irModel;
              return Row(
                children: <Widget>[
                  Expanded(
                    child: AccountTile(
                      size: widget.size.height,
                      walletAddress: widget.wallet.address,
                      username: irModel?.usernameIRRecordModel.value,
                      avatarUrl: irModel?.avatarIRRecordModel.value,
                      loadingBool: identityRegistrarState is IdentityRegistrarLoadingState,
                      usernameTextStyle: textTheme.bodyText1!.copyWith(color: DesignColors.white1),
                      addressTextStyle: textTheme.bodyText2!.copyWith(color: DesignColors.grey1),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: DesignColors.white1,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
