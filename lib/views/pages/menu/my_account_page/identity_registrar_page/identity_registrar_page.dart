import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/data_bloc/data_bloc.dart';
import 'package:miro/blocs/specific_blocs/data/query_identity_records_by_address_data_bloc.dart';
import 'package:miro/config/identity_records_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar_page/custom_entry_button.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar_page/identity_record_list_tile.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar_page/identity_record_row_layout.dart';
import 'package:miro/views/widgets/kira/kira_card.dart';
import 'package:miro/views/widgets/kira/network_guard_widget.dart';

const TextStyle headerTextStyle = TextStyle(
  fontSize: 12,
  color: DesignColors.gray2_100,
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
    return NetworkGuardWidget(
      child: KiraCard(
        child: Column(
          children: <Widget>[
            const IdentityRecordRowLayout(
              padding: EdgeInsets.all(20),
              entrySection: Text(
                'Entries',
                style: headerTextStyle,
              ),
              statusSection: Text(
                'Status',
                style: headerTextStyle,
              ),
              actionsSection: SizedBox(),
            ),
            ...IdentityRecordsConfig.defaultIdentityRecordKeys.map((String key) {
              return IdentityRecordListTile(
                identityRecordConfig: IdentityRecordsConfig.getConfig(key),
                identityKey: key,
              );
            }).toList(),
            BlocBuilder<QueryIdentityRecordsByAddressDataBloc, DataState<List<Record>>>(
              builder: (BuildContext context, DataState<List<Record>> state) {
                List<Record> customRecords = List<Record>.empty(growable: true);
                if (state is DataLoadedState<List<Record>>) {
                  customRecords = state.value
                      .where((Record record) => !IdentityRecordsConfig.defaultIdentityRecordKeys.contains(record.key))
                      .toList();
                }
                return Column(
                  children: customRecords.map((Record e) {
                    return IdentityRecordListTile(
                      identityRecordConfig: IdentityRecordsConfig.getConfig(e.key),
                      identityKey: e.key,
                    );
                  }).toList(),
                );
              },
            ),
            const CustomEntryButton(
              padding: kDefaultListItemPadding,
              borderSide: kListItemBorderSide,
            ),
          ],
        ),
      ),
    );
  }

  void _refresh() {
    if (mounted) {
      BlocProvider.of<QueryIdentityRecordsByAddressDataBloc>(context).add(LoadDataEvent());
    }
  }
}
