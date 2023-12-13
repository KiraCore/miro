import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: KiraElevatedButton(
            height: 40,
            width: 200,
            title: S.of(context).txButtonClaimAllRewards,
            onPressed: () => KiraRouter.of(context).push(
              const TransactionsWrapperRoute(
                children: <PageRouteInfo>[
                  StakingTxClaimRewardsRoute(),
                ],
              ),
            ),
          ),
        ),
        const Spacer(flex: 3),
        ListSearchWidget<ValidatorModel>(
          textEditingController: searchBarTextEditingController,
          hint: S.of(context).validatorsHintSearch,
        ),
      ],
    );
  }
}
