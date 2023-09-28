import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/pending_verification.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/record.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class IRModel extends Equatable {
  final IRRecordModel usernameIRRecordModel;
  final IRRecordModel descriptionIRRecordModel;
  final IRRecordModel socialMediaIRRecordModel;
  final IRRecordModel avatarIRRecordModel;
  final WalletAddress walletAddress;
  final List<IRRecordModel> otherIRRecordModelList;

  const IRModel({
    required this.usernameIRRecordModel,
    required this.descriptionIRRecordModel,
    required this.socialMediaIRRecordModel,
    required this.avatarIRRecordModel,
    required this.walletAddress,
    this.otherIRRecordModelList = const <IRRecordModel>[],
  });

  IRModel.empty({required this.walletAddress})
      : usernameIRRecordModel = const IRRecordModel.empty(key: 'username'),
        descriptionIRRecordModel = const IRRecordModel.empty(key: 'description'),
        socialMediaIRRecordModel = const IRRecordModel.empty(key: 'social'),
        avatarIRRecordModel = const IRRecordModel.empty(key: 'avatar'),
        otherIRRecordModelList = <IRRecordModel>[];

  factory IRModel.fromDto({
    required WalletAddress walletAddress,
    required List<Record> records,
    required List<PendingVerification> pendingVerifications,
  }) {
    IRRecordModel usernameIRRecordModel = const IRRecordModel.empty(key: 'username');
    IRRecordModel descriptionIRRecordModel = const IRRecordModel.empty(key: 'description');
    IRRecordModel socialMediaIRRecordModel = const IRRecordModel.empty(key: 'social');
    IRRecordModel avatarIRRecordModel = const IRRecordModel.empty(key: 'avatar');
    List<IRRecordModel> otherIRRecordModelList = <IRRecordModel>[];

    for (Record record in records) {
      List<WalletAddress> pendingVerifiersAddresses = pendingVerifications
          .where((PendingVerification pendingVerification) => pendingVerification.recordIds.contains(record.id))
          .map((PendingVerification pendingVerification) => WalletAddress.fromBech32(pendingVerification.verifierAddress))
          .toSet()
          .toList();

      IRRecordModel irRecordModel = IRRecordModel.fromDto(record, pendingVerifiersAddresses);
      switch (irRecordModel.key) {
        case 'username':
          usernameIRRecordModel = irRecordModel;
          break;
        case 'description':
          descriptionIRRecordModel = irRecordModel;
          break;
        case 'social':
          socialMediaIRRecordModel = irRecordModel;
          break;
        case 'avatar':
          avatarIRRecordModel = irRecordModel;
          break;
        default:
          otherIRRecordModelList.add(irRecordModel);
          break;
      }
    }

    return IRModel(
      usernameIRRecordModel: usernameIRRecordModel,
      descriptionIRRecordModel: descriptionIRRecordModel,
      socialMediaIRRecordModel: socialMediaIRRecordModel,
      avatarIRRecordModel: avatarIRRecordModel,
      walletAddress: walletAddress,
      otherIRRecordModelList: otherIRRecordModelList,
    );
  }

  bool isEmpty() {
    return usernameIRRecordModel.isEmpty() &&
        descriptionIRRecordModel.isEmpty() &&
        socialMediaIRRecordModel.isEmpty() &&
        avatarIRRecordModel.isEmpty() &&
        otherIRRecordModelList.isEmpty;
  }

  String get name => usernameIRRecordModel.value ?? walletAddress.buildBech32AddressShort(delimiter: '_');

  @override
  List<Object?> get props => <Object?>[
        usernameIRRecordModel,
        descriptionIRRecordModel,
        socialMediaIRRecordModel,
        avatarIRRecordModel,
        walletAddress,
        otherIRRecordModelList,
      ];
}
