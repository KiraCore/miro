import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class NodeMarkerPopup extends StatefulWidget {
  final Marker marker;
  final List<Marker> markerList;
  final VisualizerNodeModel visualizerNodeModel;

  const NodeMarkerPopup(this.marker, this.markerList, this.visualizerNodeModel, {super.key});

  @override
  State<StatefulWidget> createState() => _NodeMarkerPopupState();
}

class _NodeMarkerPopupState extends State<NodeMarkerPopup> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontSize: 12.0);
    return Container(
      decoration: BoxDecoration(
        color: DesignColors.black,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(width: 1.0, color: DesignColors.greyOutline),
      ),
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 300),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                KiraIdentityAvatar(
                  address: widget.visualizerNodeModel.address,
                  size: 40,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.visualizerNodeModel.ip.toString(),
                  style: textStyle,
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Text(
              '${S.of(context).validatorsTableMoniker}: ${widget.visualizerNodeModel.moniker.toString()}',
              style: textStyle,
            ),
            Text(
              '${S.of(context).visualizerDataCenter}: ${widget.visualizerNodeModel.dataCenter.toString()}',
              style: textStyle,
            ),
            Text(
              '${S.of(context).visualizerPeers}: ${widget.visualizerNodeModel.peersNumber.toString()}',
              style: textStyle,
            ),
            if (widget.visualizerNodeModel.website != null)
              Text(
                widget.visualizerNodeModel.website.toString(),
                style: textStyle,
              ),
          ],
        ),
      ),
    );
  }
}
