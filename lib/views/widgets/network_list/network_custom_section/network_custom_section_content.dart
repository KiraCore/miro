import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/views/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/network_list/network_list_tile.dart';

class NetworkCustomSectionContent extends StatefulWidget {
  final TextEditingController textEditingController;
  final NetworkCustomSectionCubit networkCustomSectionCubit;
  final ValueChanged<ANetworkStatusModel>? onConnected;

  const NetworkCustomSectionContent({
    required this.textEditingController,
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
    bool connectedNetworkExist = widget.networkCustomSectionCubit.state.connectedNetworkStatusModel != null;
    bool checkedNetworkExist = widget.networkCustomSectionCubit.state.checkedNetworkStatusModel != null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (connectedNetworkExist) ...<Widget>[
          NetworkListTile(
            networkStatusModel: widget.networkCustomSectionCubit.state.connectedNetworkStatusModel!,
            onConnected: widget.onConnected,
          ),
        ],
        if (checkedNetworkExist) ...<Widget>[
          if (connectedNetworkExist) const SizedBox(height: 16),
          Text(
            'Checked connection',
            style: textTheme.subtitle2!.copyWith(color: DesignColors.gray2_100),
          ),
          NetworkListTile(
            networkStatusModel: widget.networkCustomSectionCubit.state.checkedNetworkStatusModel!,
            onConnected: widget.onConnected,
          ),
        ],
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            controller: widget.textEditingController,
            decoration: InputDecoration(
              hintText: 'Custom address',
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              hintStyle: textTheme.bodyText1!.copyWith(color: DesignColors.white_50),
            ),
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
                  color: DesignColors.red_100,
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: KiraElevatedButton(
            title: 'Check connection',
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
    widget.textEditingController.clear();
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
    String networkAddress = widget.textEditingController.text;
    if (networkAddress.isEmpty) {
      errorNotifier.value = "Field can't be empty";
    } else if (networkUri == null) {
      errorNotifier.value = 'Invalid network address';
    } else {
      errorNotifier.value = null;
    }
    return errorNotifier.value == null;
  }

  Uri? _parseTextFieldToUri() {
    try {
      String networkAddress = widget.textEditingController.text;
      Uri networkUri = NetworkUtils.parseUrlToInterxUri(networkAddress);
      return networkUri;
    } catch (_) {
      return null;
    }
  }
}
