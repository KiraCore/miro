import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field.dart';
import 'package:miro/views/widgets/kira/kira_text_field/kira_text_field_controller.dart';

class AddCustomEntryListTile extends StatefulWidget {
  final EdgeInsets padding;
  final BorderSide borderSide;

  const AddCustomEntryListTile({
    required this.padding,
    required this.borderSide,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddCustomEntryListTile();
}

class _AddCustomEntryListTile extends State<AddCustomEntryListTile> {
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
  final VoidCallback onCancel;

  const _EditingEntryWidget({
    required this.onCancel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 334,
          child: KiraTextField(
            controller: KiraTextFieldController(),
            hint: 'Add custom entry',
          ),
        ),
        const SizedBox(width: 10),
        KiraElevatedButton(
          width: 76,
          height: 40,
          title: 'Save',
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        KiraOutlinedButton(
          width: 76,
          height: 40,
          title: 'Cancel',
          onPressed: onCancel,
        ),
      ],
    );
  }
}
