import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class BlocksDrawerPage extends StatefulWidget {
  final BlockModel blockModel;

  const BlocksDrawerPage({required this.blockModel, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkDrawerPage();
}

class _NetworkDrawerPage extends State<BlocksDrawerPage> {
  final NetworkCustomSectionCubit _networkCustomSectionCubit = globalLocator<NetworkCustomSectionCubit>();

  @override
  void dispose() {
    _networkCustomSectionCubit.resetSwitchValueWhenConnected();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle textStyle = textTheme.bodyText2!.copyWith(color: DesignColors.white2);

    String convertToAgo(DateTime input) {
      Duration diff = DateTime.now().difference(input);

      if (diff.inDays >= 1) {
        return '${diff.inDays} days ago';
      } else if (diff.inHours >= 1) {
        return '${diff.inHours} hours ago';
      } else if (diff.inMinutes >= 1) {
        return '${diff.inMinutes} minutes ago';
      } else if (diff.inSeconds >= 1) {
        return '${diff.inSeconds} seconds ago';
      } else {
        return 'just now';
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DrawerTitle(
          title: 'Block ${widget.blockModel.header.height}',
        ),
        Text(
          convertToAgo(widget.blockModel.header.time),
          style: const TextStyle(
            color: DesignColors.accent,
          ),
        ),
        const SizedBox(height: 28),
        PrefixedWidget(
          prefix: S.of(context).blocksProposer,
          child: Row(
            children: <Widget>[
              KiraIdentityAvatar(
                address: widget.blockModel.header.proposerAddress,
                size: 32,
              ),
              Text(
                '${widget.blockModel.header.proposerAddress.substring(0, 5)}...${widget.blockModel.header.proposerAddress.substring(
                  widget.blockModel.header.proposerAddress.length - 5,
                  widget.blockModel.header.proposerAddress.length,
                )}',
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyText2!.copyWith(
                  color: DesignColors.white2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).blocksChainId,
          child: Text(
            widget.blockModel.header.chainId,
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).blocksHash,
          child: Text(
            widget.blockModel.blockId.hash,
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).blocksValidatorHash,
          child: Text(
            widget.blockModel.header.validatorsHash,
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).blocksAppHash,
          child: Text(
            widget.blockModel.header.appHash,
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).blocksConsensusHash,
          child: Text(
            widget.blockModel.header.consensusHash,
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).blocksEvidenceHash,
          child: Text(
            widget.blockModel.header.evidenceHash,
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).blocksBlockSize,
          child: Text(
            widget.blockModel.blockSize,
            style: textStyle,
          ),
        ),
        const Divider(color: DesignColors.grey2),
        PrefixedWidget(
          prefix: S.of(context).blocksTxCount,
          child: Text(
            widget.blockModel.numTxs,
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
