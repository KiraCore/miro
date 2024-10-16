import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_keyfile_drawer_page/sign_in_keyfile_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_keyfile_drawer_page/sign_in_keyfile_drawer_page_state.dart';
import 'package:miro/blocs/widgets/keyfile_dropzone/keyfile_dropzone_cubit.dart';
import 'package:miro/blocs/widgets/keyfile_dropzone/keyfile_dropzone_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/utils/string_utils.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/create_wallet_link_button.dart';
import 'package:miro/views/pages/drawer/sign_in_drawer_page/sign_in_keyfile_drawer_page/keyfile_dropzone_preview.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_dropzone/kira_dropzone.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class SignInKeyfileDrawerPage extends StatefulWidget {
  const SignInKeyfileDrawerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInKeyfileDrawerPage();
}

class _SignInKeyfileDrawerPage extends State<SignInKeyfileDrawerPage> {
  final KiraTextFieldController keyfileKiraTextFieldController = KiraTextFieldController();

  @override
  void dispose() {
    keyfileKiraTextFieldController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KeyfileDropzoneCubit>(
      create: (_) => KeyfileDropzoneCubit(),
      child: BlocProvider<SignInKeyfileDrawerPageCubit>(
        create: (BuildContext context) => SignInKeyfileDrawerPageCubit(
          authCubit: globalLocator<AuthCubit>(),
          passwordTextEditingController: keyfileKiraTextFieldController.textEditingController,
          keyfileDropzoneCubit: context.read<KeyfileDropzoneCubit>(),
        ),
        child: BlocConsumer<SignInKeyfileDrawerPageCubit, SignInKeyfileDrawerPageState>(
          listener: (BuildContext context, SignInKeyfileDrawerPageState signInKeyfileDrawerPageState) {
            String? errorMessage = _selectTextFieldErrorMessage(signInKeyfileDrawerPageState.keyfileExceptionType);
            keyfileKiraTextFieldController.setErrorMessage(errorMessage);
            _selectDropzoneErrorMessage(signInKeyfileDrawerPageState.keyfileExceptionType);

            if (signInKeyfileDrawerPageState.signInSuccessBool) {
              KiraScaffold.of(context).closeEndDrawer();
            }
          },
          builder: (BuildContext context, SignInKeyfileDrawerPageState signInKeyfileDrawerPageState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DrawerTitle(
                  title: S.of(context).keyfileSignIn,
                  subtitle: S.of(context).keyfileToDropzone,
                  tooltipMessage: S.of(context).keyfileTipSecretData,
                ),
                const SizedBox(height: 37),
                BlocBuilder<KeyfileDropzoneCubit, KeyfileDropzoneState>(
                  builder: (BuildContext context, KeyfileDropzoneState keyfileDropzoneState) {
                    KeyfileExceptionType? keyfileExceptionType = signInKeyfileDrawerPageState.keyfileExceptionType;

                    return KiraDropzone(
                      hasFileBool: keyfileDropzoneState.hasFile,
                      width: double.infinity,
                      height: 128,
                      emptyLabel: S.of(context).keyfileDropHere,
                      uploadViaHtmlFile: context.read<KeyfileDropzoneCubit>().uploadFileViaHtml,
                      uploadFileManually: context.read<KeyfileDropzoneCubit>().uploadFileManually,
                      errorMessage: _selectDropzoneErrorMessage(keyfileExceptionType),
                      filePreviewErrorBuilder: (String? errorMessage) {
                        return KeyfileDropzonePreview(
                          keyfileDropzoneState: keyfileDropzoneState,
                          errorMessage: errorMessage,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                KiraTextField(
                  controller: keyfileKiraTextFieldController,
                  hint: S.of(context).keyfileEnterPassword,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(StringUtils.whitespacesRegExp),
                  ],
                  obscureText: true,
                  onChanged: (_) => context.read<SignInKeyfileDrawerPageCubit>().notifyPasswordChanged(),
                ),
                const SizedBox(height: 24),
                KiraElevatedButton(
                  disabled: signInKeyfileDrawerPageState.isSignInDisabled,
                  onPressed: context.read<SignInKeyfileDrawerPageCubit>().signIn,
                  title: S.of(context).connectWalletButtonSignIn,
                ),
                const SizedBox(height: 32),
                const CreateWalletLinkButton(),
              ],
            );
          },
        ),
      ),
    );
  }

  String? _selectDropzoneErrorMessage(KeyfileExceptionType? keyfileExceptionType) {
    if (keyfileExceptionType == KeyfileExceptionType.invalidKeyfile) {
      return S.of(context).keyfileErrorInvalid;
    } else {
      return null;
    }
  }

  String? _selectTextFieldErrorMessage(KeyfileExceptionType? keyfileExceptionType) {
    if (keyfileKiraTextFieldController.textEditingController.text.isEmpty) {
      return null;
    }
    return switch (keyfileExceptionType) {
      KeyfileExceptionType.wrongPassword => S.of(context).keyfileErrorWrongPassword,
      (_) => null,
    };
  }
}
