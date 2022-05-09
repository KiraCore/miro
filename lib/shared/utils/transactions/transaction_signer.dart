import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/auth_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/mode_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/sign_mode.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/single_mode_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/signer_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_body.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/transaction_sign_request.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';
import 'package:miro/shared/utils/transactions/signed_signature.dart';
import 'package:miro/shared/utils/transactions/std_sign_doc.dart';
import 'package:pointycastle/ecc/api.dart';

class TransactionSigner {
  /// Signs the given [stdTx] using the info contained inside the
  /// given [wallet] and returns a new [StdTx] containing the signatures
  /// inside it.
  static SignedTransaction sign({
    required UnsignedTransaction unsignedTransaction,
    required TransactionNetworkData transactionNetworkData,
    required ECPrivateKey ecPrivateKey,
    required ECPublicKey ecPublicKey,
  }) {
    final StdSignDoc signDoc = StdSignDoc(
      sequence: transactionNetworkData.sequence,
      accountNumber: transactionNetworkData.accountNumber,
      chainId: transactionNetworkData.chainId,
      messages: unsignedTransaction.messages,
      fee: unsignedTransaction.fee,
      memo: unsignedTransaction.memo,
    );

    final SignedSignature signedSignature = SignedSignature.sign(
      signDoc: signDoc,
      ecPrivateKey: ecPrivateKey,
      ecPublicKey: ecPublicKey,
    );

    // Create the signed transaction
    const ModeInfo modeInfo = ModeInfo(
      single: SingleModeInfo(
        mode: SignMode.SIGN_MODE_LEGACY_AMINO_JSON,
      ),
    );

    return SignedTransaction(
      body: TxBody(
        messages: unsignedTransaction.messages,
        memo: unsignedTransaction.memo,
      ),
      authInfo: AuthInfo(
        signerInfos: <SignerInfo>[
          SignerInfo(
            publicKey: signedSignature.publicKey,
            modeInfo: modeInfo,
            sequence: transactionNetworkData.sequence,
          ),
        ],
        fee: unsignedTransaction.fee,
      ),
      signatures: <String>[signedSignature.signature],
    );
  }
}
