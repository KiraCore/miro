import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/shared/utils/extensions/date_time_extension.dart';
import 'package:miro/views/widgets/buttons/ink_wrapper.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/key_value/copy_hover_title_value.dart';
import 'package:miro/views/widgets/generic/key_value/detail_title.dart';
import 'package:miro/views/widgets/generic/key_value/detail_value.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class BlockDetailsWidget extends StatelessWidget {
  final BlockModel blockModel;

  const BlockDetailsWidget({required this.blockModel, super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              InkWrapper(
                onTap: () => Navigator.pop(context),
                padding: const EdgeInsets.all(12),
                borderRadius: BorderRadius.circular(150),
                child: const Icon(
                  Icons.arrow_back_sharp,
                  color: DesignColors.white1,
                  size: 50,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 14),
                  Text(
                    '${S.of(context).block} ${blockModel.header.height}',
                    style: textTheme.displayMedium!.copyWith(
                      color: DesignColors.white1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    blockModel.header.time.toAgeAgo(context),
                    style: const TextStyle(
                      color: DesignColors.accent,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _CommonDetails(blockModel: blockModel),
          ),
        ],
      ),
    );
  }
}

class _CommonDetails extends StatelessWidget {
  const _CommonDetails({required this.blockModel});

  final BlockModel blockModel;

  @override
  Widget build(BuildContext context) {
    Widget divider = const SizedBox(height: 24);
    Widget rowDivider = const SizedBox(width: 24);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DetailTitle(S.of(context).blocksProposer),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CopyButton(
                        value: blockModel.header.proposerAddress,
                        notificationText: S.of(context).toastSuccessfullyCopied,
                      ),
                      const SizedBox(width: 4),
                      KiraIdentityAvatar(
                        address: blockModel.header.proposerAddress,
                        size: 24,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: KiraToolTip(
                          childMargin: EdgeInsets.zero,
                          message: blockModel.header.proposerAddress,
                          child: DetailValue(blockModel.header.proposerAddress),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            rowDivider,
            Expanded(
              child: CopyHoverTitleValue(title: S.of(context).blocksChainId, value: blockModel.header.chainId),
            ),
          ],
        ),
        divider,
        Row(
          children: <Widget>[
            Expanded(
              child: CopyHoverTitleValue(title: S.of(context).blocksHash, value: blockModel.blockId.hash),
            ),
            rowDivider,
            Expanded(
              child: CopyHoverTitleValue(
                  title: S.of(context).blocksValidatorHash, value: blockModel.header.validatorsHash),
            ),
          ],
        ),
        divider,
        Row(
          children: <Widget>[
            Expanded(
              child: CopyHoverTitleValue(title: S.of(context).blocksAppHash, value: blockModel.header.appHash),
            ),
            rowDivider,
            Expanded(
              child:
                  CopyHoverTitleValue(title: S.of(context).blocksConsensusHash, value: blockModel.header.consensusHash),
            ),
          ],
        ),
        divider,
        Row(
          children: <Widget>[
            Expanded(
              child:
                  CopyHoverTitleValue(title: S.of(context).blocksEvidenceHash, value: blockModel.header.evidenceHash),
            ),
            rowDivider,
            Expanded(
              child: CopyHoverTitleValue(
                  title: S.of(context).blocksValidatorHash, value: blockModel.header.validatorsHash),
            ),
          ],
        ),
        divider,
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DetailTitle(S.of(context).blocksBlockSize),
                  const SizedBox(height: 4),
                  DetailValue(blockModel.blockSize.toString()),
                ],
              ),
            ),
            rowDivider,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DetailTitle(S.of(context).blocksTxCount),
                  const SizedBox(height: 4),
                  DetailValue(blockModel.numTxs.toString()),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
