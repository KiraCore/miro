import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/data_bloc/data_bloc.dart';
import 'package:miro/blocs/specific_blocs/data/query_identity_records_by_address_data_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/query_identity_records_by_address_resp.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/network_provider/network_states.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/identity_record_page/identity_record_page.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar_page/add_custom_entry_list_tile.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar_page/identity_registrar_preview.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/status_chip.dart';
import 'package:miro/views/widgets/kira/kira_card.dart';
import 'package:provider/provider.dart';

const TextStyle headerTextStyle = TextStyle(
  fontSize: 12,
  color: DesignColors.gray2_100,
);

const EdgeInsets kDefaultListItemPadding = EdgeInsets.all(20);
const BorderSide kListItemBorderSide = BorderSide(
  color: Color(0xFF343261),
  width: 1,
);

class IdentityRegistrarPage extends StatefulWidget {
  const IdentityRegistrarPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IdentityRegistrarPage();
}

class _IdentityRegistrarPage extends State<IdentityRegistrarPage> {
  NetworkProvider networkProvider = globalLocator<NetworkProvider>();

  @override
  void initState() {
    networkProvider.addListener(_refresh);
    super.initState();
  }

  @override
  void dispose() {
    networkProvider.removeListener(_refresh);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant IdentityRegistrarPage oldWidget) {
    _refresh();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(
      builder: (BuildContext context, NetworkProvider networkProvider, _) {
        if (networkProvider.state is DisconnectedNetworkState) {
          return _DisconnectedNetworkWidget();
        } else if (networkProvider.state is ConnectingNetworkState) {
          return SizedBox(
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                CenterLoadSpinner(),
                SizedBox(height: 10),
                Text('Connecting to network...'),
              ],
            ),
          );
        } else {
          return KiraCard(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: const <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Entries',
                          style: headerTextStyle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Status',
                          style: headerTextStyle,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                const _IdentityListTile(
                  label: 'Username',
                  valueKey: 'username',
                  identityPreviewType: IdentityPreviewType.singleText,
                ),
                const _IdentityListTile(
                  label: 'Description',
                  valueKey: 'description',
                  identityPreviewType: IdentityPreviewType.singleText,
                ),
                const _IdentityListTile(
                  label: 'Social media',
                  valueKey: 'social_media',
                  identityPreviewType: IdentityPreviewType.socialList,
                ),
                const _IdentityListTile(
                  label: 'Avatar',
                  valueKey: 'avatar',
                  identityPreviewType: IdentityPreviewType.image,
                ),
                const _IdentityListTile(
                  label: 'Email or other URL',
                  valueKey: 'contact',
                  identityPreviewType: IdentityPreviewType.socialList,
                ),
                const AddCustomEntryListTile(
                  padding: kDefaultListItemPadding,
                  borderSide: kListItemBorderSide,
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void _refresh() {
    if (mounted) {
      BlocProvider.of<QueryIdentityRecordsByAddressDataBloc>(context).add(LoadDataEvent());
    }
  }
}

class _DisconnectedNetworkWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text('No internet connection');
  }
}

class _IdentityListTile extends StatelessWidget {
  final String label;
  final String valueKey;
  final IdentityPreviewType identityPreviewType;

  const _IdentityListTile({
    required this.label,
    required this.valueKey,
    required this.identityPreviewType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryIdentityRecordsByAddressDataBloc, DataState<QueryIdentityRecordsByAddressResp>>(
      builder: (BuildContext context, DataState<QueryIdentityRecordsByAddressResp> state) {
        Record? record;
        if (state is DataLoadedState<QueryIdentityRecordsByAddressResp>) {
          record = state.value.recordsMap[valueKey];
        }
        return MouseStateListener(
          onTap: () {
            KiraScaffold.of(context).navigateEndDrawerRoute(
              IdentityRecordPage(
                label: label,
                record: record,
              ),
            );
          },
          childBuilder: (Set<MaterialState> states) {
            return Container(
              padding: kDefaultListItemPadding,
              decoration: const BoxDecoration(
                border: Border(
                  top: kListItemBorderSide,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: IdentityRegistrarPreview(
                      record: record,
                      label: label,
                      identityPreviewType: identityPreviewType,
                    ),
                  ),
                  Expanded(
                    child: StatusChip(
                      value: getRecordState(state),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        if (record == null)
                          KiraElevatedButton(
                            width: 76,
                            height: 40,
                            onPressed: () {},
                            title: 'Add',
                          ),
                        if (record != null) ...<Widget>[
                          const SizedBox(width: 10),
                          KiraOutlinedButton(
                            width: 76,
                            height: 40,
                            onPressed: () {},
                            title: 'Edit',
                          ),
                        ],
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  StatusChipValue getRecordState(DataState<QueryIdentityRecordsByAddressResp> state) {
    if (state is DataLoadingState<QueryIdentityRecordsByAddressResp>) {
      return StatusChipValue.loading;
    } else {
      return StatusChipValue.notVerified;
    }
  }
}
