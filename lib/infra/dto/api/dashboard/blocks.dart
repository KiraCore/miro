import 'package:equatable/equatable.dart';

class Blocks extends Equatable {
  final int currentHeight;
  final int sinceGenesis;
  final int pendingTransactions;
  final int currentTransactions;
  final double latestTime;
  final double averageTime;

  const Blocks({
    required this.currentHeight,
    required this.sinceGenesis,
    required this.pendingTransactions,
    required this.currentTransactions,
    required this.latestTime,
    required this.averageTime,
  });

  factory Blocks.fromJson(Map<String, dynamic> json) {
    return Blocks(
      currentHeight: json['current_height'] as int,
      sinceGenesis: json['since_genesis'] as int,
      pendingTransactions: json['pending_transactions'] as int,
      currentTransactions: json['current_transactions'] as int,
      latestTime: json['latest_time'] as double,
      averageTime: json['average_time'] as double,
    );
  }

  @override
  String toString() {
    return 'Blocks{currentHeight: $currentHeight, sinceGenesis: $sinceGenesis, pendingTransactions: $pendingTransactions, currentTransactions: $currentTransactions, latestTime: $latestTime, averageTime: $averageTime}';
  }

  @override
  List<Object?> get props => <Object>[
        currentHeight,
        sinceGenesis,
        pendingTransactions,
        currentTransactions,
        latestTime,
        averageTime,
      ];
}
