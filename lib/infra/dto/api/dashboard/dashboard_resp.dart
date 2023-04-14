import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/dashboard/blocks.dart';
import 'package:miro/infra/dto/api/dashboard/current_block_validator.dart';
import 'package:miro/infra/dto/api/dashboard/proposals.dart';
import 'package:miro/infra/dto/api/dashboard/validators.dart';

class DashboardResp extends Equatable {
  final String consensusHealth;
  final CurrentBlockValidator currentBlockValidator;
  final Validators validators;
  final Blocks blocks;
  final Proposals proposals;

  const DashboardResp({
    required this.consensusHealth,
    required this.currentBlockValidator,
    required this.validators,
    required this.blocks,
    required this.proposals,
  });

  factory DashboardResp.fromJson(Map<String, dynamic> json) {
    return DashboardResp(
      consensusHealth: json['consensus_health'] as String,
      currentBlockValidator: CurrentBlockValidator.fromJson(json['current_block_validator'] as Map<String, dynamic>),
      validators: Validators.fromJson(json['validators'] as Map<String, dynamic>),
      blocks: Blocks.fromJson(json['blocks'] as Map<String, dynamic>),
      proposals: Proposals.fromJson(json['proposals'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => <Object>[consensusHealth, currentBlockValidator, validators, blocks, proposals];
}
