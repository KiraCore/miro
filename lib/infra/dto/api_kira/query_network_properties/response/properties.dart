import 'package:equatable/equatable.dart';

class Properties extends Equatable {
  final String abstentionRankDecreaseAmount;
  final String dappAutoDenounceTime;
  final String dappBondDuration;
  final String dappVerifierBond;
  final bool enableForeignFeePayments;
  final bool enableTokenBlacklist;
  final bool enableTokenWhitelist;
  final String inactiveRankDecreasePercent;
  final String inflationPeriod;
  final String inflationRate;
  final String maxAbstention;
  final String maxAnnualInflation;
  final String maxCustodyBufferSize;
  final String maxCustodyTxSize;
  final String maxDelegators;
  final String maxJailedPercentage;
  final String maxMischance;
  final String maxProposalChecksumSize;
  final String maxProposalDescriptionSize;
  final String maxProposalPollOptionCount;
  final String maxProposalPollOptionSize;
  final String maxProposalReferenceSize;
  final String maxProposalTitleSize;
  final String maxSlashingPercentage;
  final String minCollectiveBond;
  final String minCollectiveBondingTime;
  final String minCollectiveClaimPeriod;
  final String minCustodyReward;
  final String minDelegationPushout;
  final String minIdentityApprovalTip;
  final String minProposalEnactmentBlocks;
  final String minProposalEndBlocks;
  final String minTxFee;
  final String minValidators;
  final String mischanceConfidence;
  final String mischanceRankDecreaseAmount;
  final String minimumProposalEndTime;
  final String proposalEnactmentTime;
  final String poorNetworkMaxBankSend;
  final String ubiHardcap;
  final String unjailMaxTime;
  final String uniqueIdentityKeys;
  final String unstakingPeriod;
  final String validatorRecoveryBond;
  final String validatorsFeeShare;
  final String voteQuorum;

  const Properties({
    required this.abstentionRankDecreaseAmount,
    required this.dappAutoDenounceTime,
    required this.dappBondDuration,
    required this.dappVerifierBond,
    required this.enableForeignFeePayments,
    required this.enableTokenBlacklist,
    required this.enableTokenWhitelist,
    required this.inactiveRankDecreasePercent,
    required this.inflationPeriod,
    required this.inflationRate,
    required this.maxAbstention,
    required this.maxAnnualInflation,
    required this.maxCustodyBufferSize,
    required this.maxCustodyTxSize,
    required this.maxDelegators,
    required this.maxJailedPercentage,
    required this.maxMischance,
    required this.maxProposalChecksumSize,
    required this.maxProposalDescriptionSize,
    required this.maxProposalPollOptionCount,
    required this.maxProposalPollOptionSize,
    required this.maxProposalReferenceSize,
    required this.maxProposalTitleSize,
    required this.maxSlashingPercentage,
    required this.minCollectiveBond,
    required this.minCollectiveBondingTime,
    required this.minCollectiveClaimPeriod,
    required this.minCustodyReward,
    required this.minDelegationPushout,
    required this.minIdentityApprovalTip,
    required this.minProposalEnactmentBlocks,
    required this.minProposalEndBlocks,
    required this.minTxFee,
    required this.minValidators,
    required this.mischanceConfidence,
    required this.mischanceRankDecreaseAmount,
    required this.minimumProposalEndTime,
    required this.proposalEnactmentTime,
    required this.poorNetworkMaxBankSend,
    required this.ubiHardcap,
    required this.unjailMaxTime,
    required this.uniqueIdentityKeys,
    required this.unstakingPeriod,
    required this.validatorRecoveryBond,
    required this.validatorsFeeShare,
    required this.voteQuorum,
  });

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      abstentionRankDecreaseAmount: json['abstentionRankDecreaseAmount'] as String,
      dappAutoDenounceTime: json['dappAutoDenounceTime'] as String,
      dappBondDuration: json['dappBondDuration'] as String,
      dappVerifierBond: json['dappVerifierBond'] as String,
      enableForeignFeePayments: json['enableForeignFeePayments'] as bool,
      enableTokenBlacklist: json['enableTokenBlacklist'] as bool,
      enableTokenWhitelist: json['enableTokenWhitelist'] as bool,
      inactiveRankDecreasePercent: json['inactiveRankDecreasePercent'] as String,
      inflationPeriod: json['inflationPeriod'] as String,
      inflationRate: json['inflationRate'] as String,
      maxAbstention: json['maxAbstention'] as String,
      maxAnnualInflation: json['maxAnnualInflation'] as String,
      maxCustodyBufferSize: json['maxCustodyBufferSize'] as String,
      maxCustodyTxSize: json['maxCustodyTxSize'] as String,
      maxDelegators: json['maxDelegators'] as String,
      maxJailedPercentage: json['maxJailedPercentage'] as String,
      maxMischance: json['maxMischance'] as String,
      maxProposalChecksumSize: json['maxProposalChecksumSize'] as String,
      maxProposalDescriptionSize: json['maxProposalDescriptionSize'] as String,
      maxProposalPollOptionCount: json['maxProposalPollOptionCount'] as String,
      maxProposalPollOptionSize: json['maxProposalPollOptionSize'] as String,
      maxProposalReferenceSize: json['maxProposalReferenceSize'] as String,
      maxProposalTitleSize: json['maxProposalTitleSize'] as String,
      maxSlashingPercentage: json['maxSlashingPercentage'] as String,
      minCollectiveBond: json['minCollectiveBond'] as String,
      minCollectiveBondingTime: json['minCollectiveBondingTime'] as String,
      minCollectiveClaimPeriod: json['minCollectiveClaimPeriod'] as String,
      minCustodyReward: json['minCustodyReward'] as String,
      minDelegationPushout: json['minDelegationPushout'] as String,
      minIdentityApprovalTip: json['minIdentityApprovalTip'] as String,
      minProposalEnactmentBlocks: json['minProposalEnactmentBlocks'] as String,
      minProposalEndBlocks: json['minProposalEndBlocks'] as String,
      minTxFee: json['minTxFee'] as String,
      minValidators: json['minValidators'] as String,
      mischanceConfidence: json['mischanceConfidence'] as String,
      mischanceRankDecreaseAmount: json['mischanceRankDecreaseAmount'] as String,
      minimumProposalEndTime: json['minimumProposalEndTime'] as String,
      proposalEnactmentTime: json['proposalEnactmentTime'] as String,
      poorNetworkMaxBankSend: json['poorNetworkMaxBankSend'] as String,
      ubiHardcap: json['ubiHardcap'] as String,
      unjailMaxTime: json['unjailMaxTime'] as String,
      uniqueIdentityKeys: json['uniqueIdentityKeys'] as String,
      unstakingPeriod: json['unstakingPeriod'] as String,
      validatorRecoveryBond: json['validatorRecoveryBond'] as String,
      validatorsFeeShare: json['validatorsFeeShare'] as String,
      voteQuorum: json['voteQuorum'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[
        abstentionRankDecreaseAmount,
        dappAutoDenounceTime,
        dappBondDuration,
        dappVerifierBond,
        enableForeignFeePayments,
        enableTokenBlacklist,
        enableTokenWhitelist,
        inactiveRankDecreasePercent,
        inflationPeriod,
        inflationRate,
        maxAbstention,
        maxAnnualInflation,
        maxCustodyBufferSize,
        maxCustodyTxSize,
        maxDelegators,
        maxJailedPercentage,
        maxMischance,
        maxProposalChecksumSize,
        maxProposalDescriptionSize,
        maxProposalPollOptionCount,
        maxProposalPollOptionSize,
        maxProposalReferenceSize,
        maxProposalTitleSize,
        maxSlashingPercentage,
        minCollectiveBond,
        minCollectiveBondingTime,
        minCollectiveClaimPeriod,
        minCustodyReward,
        minDelegationPushout,
        minIdentityApprovalTip,
        minProposalEnactmentBlocks,
        minProposalEndBlocks,
        minTxFee,
        minValidators,
        mischanceConfidence,
        mischanceRankDecreaseAmount,
        minimumProposalEndTime,
        proposalEnactmentTime,
        poorNetworkMaxBankSend,
        ubiHardcap,
        unjailMaxTime,
        uniqueIdentityKeys,
        unstakingPeriod,
        validatorRecoveryBond,
        validatorsFeeShare,
        voteQuorum,
      ];
}
