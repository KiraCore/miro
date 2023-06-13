import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class VisualizerListItemMobile extends StatelessWidget {
  final VisualizerNodeModel visualizerNodeItemModel;

  const VisualizerListItemMobile({
    required this.visualizerNodeItemModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: DesignColors.black,
      ),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 40,
                    child: KiraIdentityAvatar(
                      address: visualizerNodeItemModel.address,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        visualizerNodeItemModel.moniker,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge!.copyWith(
                          color: DesignColors.white1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        visualizerNodeItemModel.ip,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge!.copyWith(
                          color: DesignColors.white2,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CopyButton(
                    value: visualizerNodeItemModel.ip,
                    notificationText: S.of(context).toastSuccessfullyCopied,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: DesignColors.grey2),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    S.of(context).visualizerCountry,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium!.copyWith(
                      color: DesignColors.white2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      visualizerNodeItemModel.countryLatLongModel.country,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge!.copyWith(
                        color: DesignColors.white1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    S.of(context).visualizerDataCenter,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium!.copyWith(
                      color: DesignColors.white2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      visualizerNodeItemModel.dataCenter,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge!.copyWith(
                        color: DesignColors.white1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    S.of(context).visualizerPeers,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium!.copyWith(
                      color: DesignColors.white2,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      visualizerNodeItemModel.peersNumber.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge!.copyWith(
                        color: DesignColors.white1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
