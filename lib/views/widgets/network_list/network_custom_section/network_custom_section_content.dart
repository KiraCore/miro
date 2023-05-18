import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';
import 'package:miro/views/widgets/network_list/network_list_tile.dart';

class NetworkCustomSectionContent extends StatefulWidget {
  final bool arrowEnabledBool;
  final KiraTextFieldController kiraTextFieldController;
  final NetworkCustomSectionCubit networkCustomSectionCubit;
  final ValueChanged<ANetworkStatusModel>? onConnected;

  const NetworkCustomSectionContent({
    required this.arrowEnabledBool,
    required this.kiraTextFieldController,
    required this.networkCustomSectionCubit,
    this.onConnected,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkCustomSectionContent();
}

class _NetworkCustomSectionContent extends State<NetworkCustomSectionContent> {
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool connectedNetworkExistsBool = widget.networkCustomSectionCubit.state.connectedNetworkStatusModel != null;
    bool lastConnectedNetworkExistsBool = widget.networkCustomSectionCubit.state.lastConnectedNetworkStatusModel != null;
    bool checkedNetworkExistsBool = widget.networkCustomSectionCubit.state.checkedNetworkStatusModel != null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (connectedNetworkExistsBool) ...<Widget>[
          NetworkListTile(
            networkStatusModel: widget.networkCustomSectionCubit.state.connectedNetworkStatusModel!,
            onConnected: widget.onConnected,
            arrowEnabledBool: widget.arrowEnabledBool,
          ),
        ] else if (lastConnectedNetworkExistsBool) ...<Widget>[
          NetworkListTile(
            networkStatusModel: widget.networkCustomSectionCubit.state.lastConnectedNetworkStatusModel!,
            onConnected: widget.onConnected,
            arrowEnabledBool: widget.arrowEnabledBool,
          ),
        ],
        if (checkedNetworkExistsBool) ...<Widget>[
          if (connectedNetworkExistsBool) const SizedBox(height: 16),
          Text(
            S.of(context).networkCheckedConnection,
            style: textTheme.subtitle2!.copyWith(color: DesignColors.white2),
          ),
          NetworkListTile(
            networkStatusModel: widget.networkCustomSectionCubit.state.checkedNetworkStatusModel!,
            onConnected: widget.onConnected,
            arrowEnabledBool: widget.arrowEnabledBool,
          ),
        ],
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: KiraTextField(
            controller: widget.kiraTextFieldController,
            hint: S.of(context).networkHintCustomAddress,
          ),
        ),
        ValueListenableBuilder<String?>(
          valueListenable: errorNotifier,
          builder: (_, String? errorMessage, __) {
            if (errorMessage == null) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                errorMessage,
                style: textTheme.caption!.copyWith(
                  color: DesignColors.redStatus1,
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: KiraElevatedButton(
            title: S.of(context).networkButtonCheckConnection,
            onPressed: _pressCheckConnectionButton,
          ),
        ),
      ],
    );
  }

  Future<void> _pressCheckConnectionButton() async {
    Uri? uri = _buildUri();
    if (uri == null) {
      return;
    }
    widget.kiraTextFieldController.textController.clear();
    await widget.networkCustomSectionCubit.checkConnection(uri);
  }

  Uri? _buildUri() {
    bool addressValid = _validateNetworkAddress();
    if (addressValid == false) {
      return null;
    }
    Uri uri = _parseTextFieldToUri()!;
    return uri;
  }

  bool _validateNetworkAddress() {
    Uri? networkUri = _parseTextFieldToUri();
    String networkAddress = widget.kiraTextFieldController.textController.text;
    if (networkAddress.isEmpty) {
      errorNotifier.value = S.of(context).networkErrorAddressEmpty;
    } else if (networkUri == null) {
      errorNotifier.value = S.of(context).networkErrorAddressInvalid;
    } else {
      errorNotifier.value = null;
    }
    return errorNotifier.value == null;
  }

  Uri? _parseTextFieldToUri() {
    try {
      String networkAddress = widget.kiraTextFieldController.textController.text;
      Uri networkUri = NetworkUtils.parseUrlToInterxUri(networkAddress);
      return networkUri;
    } catch (_) {
      return null;
    }
  }
}
