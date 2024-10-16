import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_private_key_drawer_page/sign_in_private_key_drawer_page_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/utils/string_utils.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/create_wallet_link_button.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class SignInPrivateKeyDrawerPage extends StatefulWidget {
  const SignInPrivateKeyDrawerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInPrivateKeyDrawerPage();
}

class _SignInPrivateKeyDrawerPage extends State<SignInPrivateKeyDrawerPage> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final KiraTextFieldController keyKiraTextFieldController = KiraTextFieldController();

  @override
  void dispose() {
    keyKiraTextFieldController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInPrivateKeyDrawerPageCubit>(
      create: (BuildContext context) => SignInPrivateKeyDrawerPageCubit(),
      child: BlocConsumer<SignInPrivateKeyDrawerPageCubit, ASignInPrivateKeyDrawerPageState>(
        listener: (BuildContext context, ASignInPrivateKeyDrawerPageState state) {
          if (state is SignInPrivateKeyDrawerPageSuccessState) {
            KiraScaffold.of(context).closeEndDrawer();
          } else if (state is SignInPrivateKeyDrawerPageErrorState) {
            String? errorMessage = _selectTextFieldErrorMessage();
            keyKiraTextFieldController.setErrorMessage(errorMessage);
          } else {
            keyKiraTextFieldController.setErrorMessage(null);
          }
        },
        builder: (BuildContext context, ASignInPrivateKeyDrawerPageState state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DrawerTitle(
                title: S.of(context).signInPrivateKeyTitle,
              ),
              const SizedBox(height: 37),
              KiraTextField(
                controller: keyKiraTextFieldController,
                hint: S.of(context).signInPrivateKeyFieldPlaceholder,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(StringUtils.hexadecimalRegExp),
                  LengthLimitingTextInputFormatter(SignInPrivateKeyDrawerPageCubit.ethereumPrivateKeyLength),
                ],
                obscureText: true,
                onChanged: (_) => context.read<SignInPrivateKeyDrawerPageCubit>().handleKeyChanged(),
              ),
              const SizedBox(height: 24),
              KiraElevatedButton(
                disabled: state is! SignInPrivateKeyDrawerPageInitialState,
                onPressed: () =>
                    context.read<SignInPrivateKeyDrawerPageCubit>().submitKey(keyKiraTextFieldController.textEditingController.text),
                title: S.of(context).connectWalletButtonSignIn,
              ),
              const SizedBox(height: 32),
              const CreateWalletLinkButton(),
            ],
          );
        },
      ),
    );
  }

  String? _selectTextFieldErrorMessage() {
    if (keyKiraTextFieldController.textEditingController.text.isEmpty) {
      return null;
    }
    return S.of(context).signInPrivateKeyFieldError;
  }
}
