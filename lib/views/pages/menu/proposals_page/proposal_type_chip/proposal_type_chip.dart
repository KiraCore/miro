import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';

class ProposalTypeChip extends StatelessWidget {
  final ProposalModel proposalModel;

  const ProposalTypeChip({
    required this.proposalModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: DesignColors.greenStatus1.withAlpha(20),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          proposalModel.proposalTitle,
          style: textTheme.bodySmall!.copyWith(
            color: DesignColors.white1,
          ),
        ),
      ),
    );
  }
}
