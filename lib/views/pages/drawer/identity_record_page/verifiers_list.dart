import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/drawer/identity_record_page/add_verifier_button.dart';
import 'package:miro/views/widgets/generic/fake_text_field.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class VerifiersList extends StatelessWidget {
  final Record? record;

  const VerifiersList({
    required this.record,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FakeTextField(
        label: 'Verifiers',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 8),
            const AddVerifierButton(),
            const SizedBox(height: 8),
            if (record != null)
              ...record!.verifiers
                  .map((String verifier) => VerifierListItem(
                        address: verifier,
                        status: VerifyStatus.verified,
                      ))
                  .toList(),
          ],
        ),
      ),
    );
  }
}

enum VerifyStatus {
  verified,
  pending,
}

class VerifierListItem extends StatelessWidget {
  final WalletAddress walletAddress;
  final VerifyStatus status;

  VerifierListItem({
    required String address,
    required this.status,
    Key? key,
  })  : walletAddress = WalletAddress.fromBech32(address),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          KiraIdentityAvatar(
            address: walletAddress.bech32Address,
            size: 30,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              walletAddress.bech32Shortcut,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          if (status == VerifyStatus.pending)
            const Text(
              'Pending',
              style: TextStyle(color: DesignColors.yellow_100),
            )
          else
            const Text(
              'Confirmed',
              style: TextStyle(color: DesignColors.green_100),
            )
        ],
      ),
    );
  }
}
