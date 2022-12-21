import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkStatusIcon extends StatelessWidget {
  final ANetworkStatusModel networkStatusModel;
  final double size;

  const NetworkStatusIcon({
    required this.networkStatusModel,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        Assets.iconsNetworkStatus,
        fit: BoxFit.contain,
        allowDrawingOutsideViewBox: true,
        color: networkStatusModel.statusColor,
      ),
    );
  }
}
