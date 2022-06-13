import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/data/query_identity_records_by_address_data_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class CustomEntryButton extends StatefulWidget {
  final EdgeInsets padding;
  final BorderSide borderSide;

  const CustomEntryButton({
    required this.padding,
    required this.borderSide,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddCustomEntryListTile();
}

class _AddCustomEntryListTile extends State<CustomEntryButton> {
  final KiraTextFieldController kiraTextFieldController = KiraTextFieldController();
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: widget.padding,
      decoration: BoxDecoration(
        border: Border(
          top: widget.borderSide,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildStateWidget(),
        ],
      ),
    );
  }

  Widget _buildStateWidget() {
    if (editing) {
      return _EditingEntryWidget(
        kiraTextFieldController: kiraTextFieldController,
        onSave: () {
          BlocProvider.of<QueryIdentityRecordsByAddressDataBloc>(context)
              .addCustomEntry(kiraTextFieldController.textController.text);
          kiraTextFieldController.textController.clear();
          setState(() {
            editing = false;
          });
        },
        onCancel: () {
          setState(() {
            editing = false;
          });
        },
      );
    }
    return _AddCustomEntryButton(
      onPressed: () {
        setState(() {
          editing = true;
        });
      },
    );
  }
}

class _AddCustomEntryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddCustomEntryButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        foregroundColor: MaterialStateProperty.all(DesignColors.blue1_100),
      ),
      icon: const Icon(Icons.add),
      label: const Text('Add custom entry'),
    );
  }
}

class _EditingEntryWidget extends StatelessWidget {
  final KiraTextFieldController kiraTextFieldController;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const _EditingEntryWidget({
    required this.kiraTextFieldController,
    required this.onCancel,
    required this.onSave,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 334,
          child: KiraTextField(
            controller: kiraTextFieldController,
            validator: (String? value) {
              Map<String, Record> records = BlocProvider.of<QueryIdentityRecordsByAddressDataBloc>(context).recordsMap;
              if (value == null || value.isEmpty) {
                return 'Field cannot be empty';
              } else if (records.containsKey(value)) {
                return 'Entry already exists';
              }
              return null;
            },
            hint: 'Add custom entry',
          ),
        ),
        const SizedBox(width: 10),
        KiraElevatedButton(
          width: 76,
          height: 48,
          title: 'Save',
          onPressed: () {
            String? errorMessage = kiraTextFieldController.validate();
            if (errorMessage == null) {
              onSave();
            }
          },
        ),
        const SizedBox(width: 10),
        KiraOutlinedButton(
          width: 76,
          height: 48,
          title: 'Cancel',
          onPressed: onCancel,
        ),
      ],
    );
  }
}
