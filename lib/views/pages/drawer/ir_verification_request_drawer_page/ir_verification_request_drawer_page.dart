import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';
import 'package:miro/views/widgets/generic/expandable_text.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';

class IRVerificationRequestDrawerPage extends StatelessWidget {
  final IRInboundVerificationRequestModel irInboundVerificationRequestModel;

  const IRVerificationRequestDrawerPage({
    required this.irInboundVerificationRequestModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    IRUserProfileModel requesterIrUserProfileModel = irInboundVerificationRequestModel.requesterIrUserProfileModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DrawerTitle(
          title: irInboundVerificationRequestModel.records.length > 1
              ? S.of(context).irVerificationRequestsVerifyRecords
              : S.of(context).irVerificationRequestsVerifyRecord,
        ),
        const SizedBox(height: 32),
        AccountTile(
          size: 52,
          avatarUrl: requesterIrUserProfileModel.avatarUrl,
          username: requesterIrUserProfileModel.username,
          walletAddress: requesterIrUserProfileModel.walletAddress,
          usernameTextStyle: textTheme.bodyText1!.copyWith(color: DesignColors.white1),
          addressTextStyle: textTheme.bodyText2!.copyWith(color: DesignColors.white2),
        ),
        const SizedBox(height: 8),
        const Divider(color: DesignColors.grey2),
        const SizedBox(height: 16),
        PrefixedWidget(
          prefix: S.of(context).irVerificationRequestsCreationDate,
          child: Text(
            DateFormat('d MMM y, HH:mm').format(irInboundVerificationRequestModel.dateTime.toLocal()),
            style: textTheme.bodyText2!.copyWith(color: DesignColors.white1),
          ),
        ),
        const SizedBox(height: 16),
        PrefixedWidget(
          prefix: S.of(context).irVerificationRequestsTip,
          child: Text(
            irInboundVerificationRequestModel.tipTokenAmountModel.toString(),
            style: textTheme.bodyText2!.copyWith(color: DesignColors.white1),
          ),
        ),
        const SizedBox(height: 16),
        PrefixedWidget(
          prefix: '${irInboundVerificationRequestModel.records.length > 1
              ? S.of(context).irVerificationRequestsRecordsToVerify
              : S.of(context).irVerificationRequestsRecordToVerify}:',
          child: Column(
            children: <Widget>[
              const SizedBox(height: 8),
              if (irInboundVerificationRequestModel.records.isEmpty) ...<Widget>[
                const SizedBox(height: 8),
                Text('---', style: textTheme.bodyText2!.copyWith(color: DesignColors.white2)),
              ],
              for (String key in irInboundVerificationRequestModel.records.keys)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: DesignColors.grey2, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: DesignColors.black,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    children: <Widget>[
                      PrefixedWidget(
                        prefix: S.of(context).irTxHintKey,
                        child: ExpandableText(
                          initialTextLength: const ResponsiveValue<int>(
                            largeScreen: 500,
                            mediumScreen: 300,
                            smallScreen: 150,
                          ).get(context),
                          textLengthSeeMore: 500,
                          text: Text(
                            key,
                            style: textTheme.bodyText2!.copyWith(color: DesignColors.white1),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrefixedWidget(
                        prefix: S.of(context).irTxHintValue,
                        child: ExpandableText(
                          initialTextLength: const ResponsiveValue<int>(
                            largeScreen: 500,
                            mediumScreen: 300,
                            smallScreen: 150,
                          ).get(context),
                          textLengthSeeMore: 500,
                          text: Text(
                            irInboundVerificationRequestModel.records[key] ?? '---',
                            style: textTheme.bodyText2!.copyWith(color: DesignColors.white1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
