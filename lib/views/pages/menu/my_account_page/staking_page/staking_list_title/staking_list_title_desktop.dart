import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_search_widget.dart';

class StakingListTitleDesktop extends StatelessWidget {
  final TextEditingController searchBarTextEditingController;

  const StakingListTitleDesktop({
    required this.searchBarTextEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Spacer(flex: 2),
        Expanded(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 700),
              child: ListSearchWidget<ValidatorModel>(
                textEditingController: searchBarTextEditingController,
                hint: S.of(context).validatorsHintSearch,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
