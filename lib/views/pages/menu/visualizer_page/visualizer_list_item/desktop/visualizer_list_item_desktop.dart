import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/views/pages/menu/visualizer_page/visualizer_list_item/desktop/visualizer_list_item_desktop_layout.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class VisualizerListItemDesktop extends StatelessWidget {
  static const double height = 64;

  final VisualizerNodeModel visualizerNodeItemModel;

  const VisualizerListItemDesktop({
    required this.visualizerNodeItemModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return VisualizerListItemDesktopLayout(
      height: height,
      monikerWidget: Row(
        children: <Widget>[
          const SizedBox(width: 20),
          KiraIdentityAvatar(
            address: visualizerNodeItemModel.address,
            size: 40,
          ),
          const SizedBox(width: 10),
          Text(
            visualizerNodeItemModel.moniker,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium!.copyWith(
              color: DesignColors.white2,
            ),
          ),
        ],
      ),
      ipWidget: CopyWrapper(
        value: visualizerNodeItemModel.ip,
        notificationText: S.of(context).toastSuccessfullyCopied,
        child: Text(
          visualizerNodeItemModel.ip,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium!.copyWith(
            color: DesignColors.white2,
          ),
        ),
      ),
      peersWidget: Text(
        visualizerNodeItemModel.peersNumber.toString(),
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(
          color: DesignColors.white2,
        ),
      ),
      countryWidget: Text(
        visualizerNodeItemModel.countryLatLongModel.country,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(
          color: DesignColors.white2,
        ),
      ),
      dataCenterWidget: Text(
        visualizerNodeItemModel.dataCenter,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(
          color: DesignColors.white2,
        ),
      ),
    );
  }
}
