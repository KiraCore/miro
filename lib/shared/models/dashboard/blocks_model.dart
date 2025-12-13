import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';

class BlocksModel extends Equatable {
  final int currentHeight;
  final int sinceGenesis;
  final int pendingTransactions;
  final int currentTransactions;
  final double latestTime;
  final double averageTime;

  const BlocksModel({
    required this.currentHeight,
    required this.sinceGenesis,
    required this.pendingTransactions,
    required this.currentTransactions,
    required this.latestTime,
    required this.averageTime,
  });

  String getLatestBlocTimeString(BuildContext context) => '${latestTime.toStringAsFixed(1)} ${S.of(context).sec}';

  String getAverageBlocTimeString(BuildContext context) => '${averageTime.toStringAsFixed(1)} ${S.of(context).sec}';

  @override
  List<Object?> get props =>
      <Object>[currentHeight, sinceGenesis, pendingTransactions, currentTransactions, latestTime, averageTime];
}
