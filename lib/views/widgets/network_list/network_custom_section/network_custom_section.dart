import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';
import 'package:miro/views/widgets/network_list/network_custom_section/network_custom_section_content.dart';

class NetworkCustomSection extends StatefulWidget {
  final bool arrowEnabledBool;
  final ValueChanged<ANetworkStatusModel>? onConnected;

  const NetworkCustomSection({
    required this.arrowEnabledBool,
    this.onConnected,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkCustomSection();
}

class _NetworkCustomSection extends State<NetworkCustomSection> {
  final KiraTextFieldController kiraTextFieldController = KiraTextFieldController();
  final NetworkCustomSectionCubit networkCustomSectionCubit = globalLocator<NetworkCustomSectionCubit>();

  @override
  void dispose() {
    kiraTextFieldController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocBuilder<NetworkCustomSectionCubit, NetworkCustomSectionState>(
      bloc: networkCustomSectionCubit,
      builder: (_, NetworkCustomSectionState networkCustomSectionState) {
        bool sectionExpandedBool = networkCustomSectionState.expandedBool;
        
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      S.of(context).networkSwitchCustomAddress,
                      style: textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: DesignColors.white1,
                      ),
                    ),
                    Switch(
                      value: sectionExpandedBool,
                      onChanged: _handleSwitchChanged,
                      activeColor: DesignColors.greenStatus1,
                    ),
                  ],
                ),
              ),
              if (sectionExpandedBool)
                NetworkCustomSectionContent(
                  kiraTextFieldController: kiraTextFieldController,
                  onConnected: widget.onConnected,
                  networkCustomSectionCubit: networkCustomSectionCubit,
                  arrowEnabledBool: widget.arrowEnabledBool,
                ),
            ],
          ),
        );
      },
    );
  }

  void _handleSwitchChanged(bool expandedBool) {
    networkCustomSectionCubit.updateSwitchValue(expandedBool: expandedBool);
  }
}
