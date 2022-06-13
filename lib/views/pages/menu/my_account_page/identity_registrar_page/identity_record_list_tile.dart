import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/data_bloc/data_bloc.dart';
import 'package:miro/blocs/specific_blocs/data/query_identity_records_by_address_data_bloc.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/identity_record_page/identity_record_page.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar_page/identity_record_config.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar_page/identity_record_row_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/identity_registrar_page/identity_record_status_chip.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/kira/identity_record_preview/identity_record_preview.dart';

const EdgeInsets kDefaultListItemPadding = EdgeInsets.all(20);
const BorderSide kListItemBorderSide = BorderSide(
  color: Color(0xFF343261),
  width: 1,
);

class IdentityRecordListTile extends StatelessWidget {
  final IdentityRecordConfig? identityRecordConfig;
  final String identityKey;

  const IdentityRecordListTile({
    required this.identityRecordConfig,
    required this.identityKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryIdentityRecordsByAddressDataBloc, DataState<List<Record>>>(
      builder: (BuildContext context, DataState<List<Record>> state) {
        bool loadingStatus = state is DataLoadingState<List<Record>>;
        Record? record;
        if (!loadingStatus) {
          record = BlocProvider.of<QueryIdentityRecordsByAddressDataBloc>(context).recordsMap[identityKey];
        }
        return _IdentityRecordListTileContent(
          label: identityRecordConfig?.label,
          description: identityRecordConfig?.description,
          identityKey: identityKey,
          record: record,
          loading: loadingStatus,
          recordType: identityRecordConfig?.recordType ?? RecordType.shortText,
        );
      },
    );
  }
}

class _IdentityRecordListTileContent extends StatelessWidget {
  final String? label;
  final String identityKey;
  final String? description;
  final RecordType recordType;
  final bool loading;
  final Record? record;

  const _IdentityRecordListTileContent({
    required this.identityKey,
    required this.description,
    required this.loading,
    required this.record,
    required this.recordType,
    this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: () => _openRecordPreviewDrawer(context),
      childBuilder: (Set<MaterialState> states) {
        return IdentityRecordRowLayout(
          warningMessage: record is NewRecord ? 'To save this record, you must first add a value to it' : null,
          padding: kDefaultListItemPadding,
          decoration: const BoxDecoration(
            border: Border(
              top: kListItemBorderSide,
            ),
          ),
          entrySection: IdentityRecordPreview(
            record: record,
            label: label ?? identityKey,
            recordType: recordType,
          ),
          statusSection: IdentityRecordStatusChip(
            loading: loading,
            record: record,
          ),
          actionsSection: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              if (record == null || record!.value == null)
                KiraElevatedButton(
                  width: 76,
                  height: 40,
                  onPressed: () {},
                  title: 'Add',
                )
              else ...<Widget>[
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
        );
      },
    );
  }

  void _openRecordPreviewDrawer(BuildContext context) {
    KiraScaffold.of(context).navigateEndDrawerRoute(
      IdentityRecordPage(
        label: label ?? identityKey,
        description: description,
        record: record,
        recordType: recordType,
      ),
    );
  }
}
