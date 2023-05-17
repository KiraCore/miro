// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(time) => " (${time} minutes ago)";

  static String m1(verificationsCount) =>
      "Verifications: ${verificationsCount}";

  static String m2(amount) => "Tip must be greater or equal ${amount}";

  static String m3(separator, networkName, parsedRemainingTime) =>
      "Connecting to <${networkName}>${separator} Please wait... ${parsedRemainingTime}";

  static String m4(errorsCount) => "Found ${errorsCount} problems with server";

  static String m5(latestBlockTime) =>
      "The last available block on this interx was created long time ago ${latestBlockTime}. The displayed contents may be out of date.";

  static String m6(availableAmountText, tokenDenominationModelName) =>
      "Available: ${availableAmountText} ${tokenDenominationModelName}";

  static String m7(hash) => "Transaction hash: 0x${hash}";

  static String m8(amount) => "+ ${amount} more";

  static String m9(widgetFeeTokenAmountModel) =>
      "Transaction fee ${widgetFeeTokenAmountModel}";

  static String m10(txMsgType) => "Preview for ${txMsgType} unavailable";

  static String m11(selected) => "${selected} selected";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accounts": MessageLookupByLibrary.simpleMessage("Accounts"),
        "balances": MessageLookupByLibrary.simpleMessage("Balances"),
        "balancesAmount": MessageLookupByLibrary.simpleMessage("Amount"),
        "balancesButtonPay": MessageLookupByLibrary.simpleMessage("Pay"),
        "balancesButtonRequest":
            MessageLookupByLibrary.simpleMessage("Request"),
        "balancesDenomination":
            MessageLookupByLibrary.simpleMessage("Denomination"),
        "balancesHideSmall":
            MessageLookupByLibrary.simpleMessage("Hide small balances"),
        "balancesLastBlockTime":
            MessageLookupByLibrary.simpleMessage("Last block time: "),
        "balancesName": MessageLookupByLibrary.simpleMessage("Name"),
        "balancesSearch":
            MessageLookupByLibrary.simpleMessage("Search balances"),
        "balancesSend": MessageLookupByLibrary.simpleMessage("Send"),
        "balancesTimeSinceBlock": m0,
        "blocks": MessageLookupByLibrary.simpleMessage("Blocks"),
        "blocksAverageTime":
            MessageLookupByLibrary.simpleMessage("Average time"),
        "blocksCurrentHeight":
            MessageLookupByLibrary.simpleMessage("Current height"),
        "blocksCurrentTransactions":
            MessageLookupByLibrary.simpleMessage("Current transactions"),
        "blocksLatestTime": MessageLookupByLibrary.simpleMessage("Latest time"),
        "blocksPendingTransactions":
            MessageLookupByLibrary.simpleMessage("Pending transactions"),
        "blocksSinceGenesis":
            MessageLookupByLibrary.simpleMessage("Since genesis"),
        "browse": MessageLookupByLibrary.simpleMessage("browse"),
        "buttonReportIssues":
            MessageLookupByLibrary.simpleMessage("Report issues"),
        "connectWallet":
            MessageLookupByLibrary.simpleMessage("Connect a Wallet"),
        "connectWalletButtonSignIn":
            MessageLookupByLibrary.simpleMessage("Sign in"),
        "connectWalletConnecting":
            MessageLookupByLibrary.simpleMessage("Connecting into account..."),
        "connectWalletOptions": MessageLookupByLibrary.simpleMessage(
            "Choose one of the following options:"),
        "consensus": MessageLookupByLibrary.simpleMessage("Consensus"),
        "consensusCurrentBlockValidator":
            MessageLookupByLibrary.simpleMessage("Current Block Validator"),
        "consensusHealthy": MessageLookupByLibrary.simpleMessage("Healthy"),
        "consensusState":
            MessageLookupByLibrary.simpleMessage("Consensus state"),
        "consensusUnhealthy": MessageLookupByLibrary.simpleMessage("Unhealthy"),
        "copy": MessageLookupByLibrary.simpleMessage("Copy"),
        "createWalletAcknowledgement": MessageLookupByLibrary.simpleMessage(
            "I understand that if I lose Mnemonic or Keyfile I will never have access to account again."),
        "createWalletAddress":
            MessageLookupByLibrary.simpleMessage("Your public address:"),
        "createWalletAddressGenerating":
            MessageLookupByLibrary.simpleMessage("Generating..."),
        "createWalletButton":
            MessageLookupByLibrary.simpleMessage("Create new wallet"),
        "createWalletButtonGenerateAddress":
            MessageLookupByLibrary.simpleMessage("Generate\nnew address"),
        "createWalletDontHave":
            MessageLookupByLibrary.simpleMessage("Don\'t have a wallet?"),
        "createWalletTitle":
            MessageLookupByLibrary.simpleMessage("Create a wallet"),
        "creationDate": MessageLookupByLibrary.simpleMessage("Creation date"),
        "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "errorCannotFetchData":
            MessageLookupByLibrary.simpleMessage("Cannot fetch data"),
        "errorExplorer": MessageLookupByLibrary.simpleMessage("Error explorer"),
        "errorNoResults": MessageLookupByLibrary.simpleMessage("No results"),
        "errorPreviewNotAvailable":
            MessageLookupByLibrary.simpleMessage("Preview not available"),
        "errorUndefined":
            MessageLookupByLibrary.simpleMessage("Undefined error"),
        "errorUnknown": MessageLookupByLibrary.simpleMessage("Unknown error"),
        "governance": MessageLookupByLibrary.simpleMessage("Governance"),
        "ir": MessageLookupByLibrary.simpleMessage("Identity Registrar"),
        "irAddCustomRecord":
            MessageLookupByLibrary.simpleMessage("Add custom record"),
        "irAvatar": MessageLookupByLibrary.simpleMessage("Avatar"),
        "irDescription": MessageLookupByLibrary.simpleMessage("Description"),
        "irEntries": MessageLookupByLibrary.simpleMessage("Entries"),
        "irRecordAdd": MessageLookupByLibrary.simpleMessage("Add"),
        "irRecordConfirmedVerifications": MessageLookupByLibrary.simpleMessage(
            "Confirmed verification requests"),
        "irRecordDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "irRecordDetails":
            MessageLookupByLibrary.simpleMessage("Identity record details"),
        "irRecordEdit": MessageLookupByLibrary.simpleMessage("Edit"),
        "irRecordPendingVerifications": MessageLookupByLibrary.simpleMessage(
            "Pending verification requests"),
        "irRecordStatus": MessageLookupByLibrary.simpleMessage("Status"),
        "irRecordStatusNotVerified":
            MessageLookupByLibrary.simpleMessage("Not verified"),
        "irRecordStatusPending":
            MessageLookupByLibrary.simpleMessage("Pending"),
        "irRecordStatusVerificationsCount": m1,
        "irRecordVerifiersRequestVerification":
            MessageLookupByLibrary.simpleMessage("Request verification"),
        "irRecordVerify": MessageLookupByLibrary.simpleMessage("Verify"),
        "irSocialMedia": MessageLookupByLibrary.simpleMessage("Social media"),
        "irTxErrorTipMustBeGreater": m2,
        "irTxHintKey": MessageLookupByLibrary.simpleMessage("Key"),
        "irTxHintTip": MessageLookupByLibrary.simpleMessage("Tip"),
        "irTxHintValue": MessageLookupByLibrary.simpleMessage("Value"),
        "irTxHintVerifierWillGet":
            MessageLookupByLibrary.simpleMessage("Verifier will get"),
        "irTxTitleConfirmDeleteRecord": MessageLookupByLibrary.simpleMessage(
            "Confirm identity record deletion"),
        "irTxTitleConfirmVerificationRequest":
            MessageLookupByLibrary.simpleMessage(
                "Confirm verification request"),
        "irTxTitleRegisterIdentityRecord":
            MessageLookupByLibrary.simpleMessage("Register identity record"),
        "irTxTitleRequestIdentityRecordVerification":
            MessageLookupByLibrary.simpleMessage("Request record verification"),
        "irUsername": MessageLookupByLibrary.simpleMessage("Username"),
        "irVerificationRequests":
            MessageLookupByLibrary.simpleMessage("Verification Requests"),
        "irVerificationRequestsApprove":
            MessageLookupByLibrary.simpleMessage("Approve"),
        "irVerificationRequestsApprovedRecord":
            MessageLookupByLibrary.simpleMessage("Approved record"),
        "irVerificationRequestsApprovedRecords":
            MessageLookupByLibrary.simpleMessage("Approved records"),
        "irVerificationRequestsConfirmApproval":
            MessageLookupByLibrary.simpleMessage("Confirm approval"),
        "irVerificationRequestsConfirmRejection":
            MessageLookupByLibrary.simpleMessage("Confirm rejection"),
        "irVerificationRequestsCreationDate":
            MessageLookupByLibrary.simpleMessage("Creation date"),
        "irVerificationRequestsFrom":
            MessageLookupByLibrary.simpleMessage("From"),
        "irVerificationRequestsListSearchRequests":
            MessageLookupByLibrary.simpleMessage("Search requests"),
        "irVerificationRequestsRecordToVerify":
            MessageLookupByLibrary.simpleMessage("Record to verify"),
        "irVerificationRequestsRecords":
            MessageLookupByLibrary.simpleMessage("Records"),
        "irVerificationRequestsRecordsToVerify":
            MessageLookupByLibrary.simpleMessage("Records to verify"),
        "irVerificationRequestsReject":
            MessageLookupByLibrary.simpleMessage("Reject"),
        "irVerificationRequestsRejectedRecord":
            MessageLookupByLibrary.simpleMessage("Rejected record"),
        "irVerificationRequestsRejectedRecords":
            MessageLookupByLibrary.simpleMessage("Rejected records"),
        "irVerificationRequestsTip":
            MessageLookupByLibrary.simpleMessage("Tip"),
        "irVerificationRequestsVerifyRecord":
            MessageLookupByLibrary.simpleMessage("Verify record"),
        "irVerificationRequestsVerifyRecords":
            MessageLookupByLibrary.simpleMessage("Verify records"),
        "keyfile": MessageLookupByLibrary.simpleMessage("Keyfile"),
        "keyfileButtonDownload":
            MessageLookupByLibrary.simpleMessage("Download"),
        "keyfileCreatePassword":
            MessageLookupByLibrary.simpleMessage("Create password for keyfile"),
        "keyfileDropFile": MessageLookupByLibrary.simpleMessage("Drop file"),
        "keyfileDropHere":
            MessageLookupByLibrary.simpleMessage("Please drop Keyfile here"),
        "keyfileEnterPassword":
            MessageLookupByLibrary.simpleMessage("Enter password"),
        "keyfileErrorCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Keyfile cannot be empty"),
        "keyfileErrorPasswordsMatch":
            MessageLookupByLibrary.simpleMessage("Passwords don\'t match"),
        "keyfileHintPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "keyfileHintRepeatPassword":
            MessageLookupByLibrary.simpleMessage("Repeat password"),
        "keyfileInvalid":
            MessageLookupByLibrary.simpleMessage("Invalid Keyfile"),
        "keyfileSignIn":
            MessageLookupByLibrary.simpleMessage("Sign in with Keyfile"),
        "keyfileTip": MessageLookupByLibrary.simpleMessage(
            "Keyfile is a file which contains encrypted data."),
        "keyfileTipSecretData": MessageLookupByLibrary.simpleMessage(
            "Keyfile is your secret data that allows you to access\nto your wallet. Always keep it safe and secure."),
        "keyfileTitleDownload":
            MessageLookupByLibrary.simpleMessage("Download Keyfile"),
        "keyfileToDropzone": MessageLookupByLibrary.simpleMessage(
            "Drop Keyfile to the dropzone"),
        "keyfileToastDownloaded":
            MessageLookupByLibrary.simpleMessage("Keyfile downloaded"),
        "keyfileWarning": MessageLookupByLibrary.simpleMessage(
            "You won’t be able to download it again"),
        "keyfileWrongPassword":
            MessageLookupByLibrary.simpleMessage("Wrong password"),
        "kiraNetwork": MessageLookupByLibrary.simpleMessage("Kira Network"),
        "mnemonic": MessageLookupByLibrary.simpleMessage("Mnemonic"),
        "mnemonicEnter":
            MessageLookupByLibrary.simpleMessage("Enter your Mnemonic"),
        "mnemonicErrorEnterCorrect": MessageLookupByLibrary.simpleMessage(
            "You have to enter correct Mnemonic to sign in"),
        "mnemonicErrorInvalid":
            MessageLookupByLibrary.simpleMessage("Invalid mnemonic"),
        "mnemonicErrorInvalidChecksum":
            MessageLookupByLibrary.simpleMessage("Invalid checksum"),
        "mnemonicErrorTooShort":
            MessageLookupByLibrary.simpleMessage("Mnemonic too short"),
        "mnemonicErrorUnexpected": MessageLookupByLibrary.simpleMessage(
            "Something unexpected happened"),
        "mnemonicLoginHint": MessageLookupByLibrary.simpleMessage(
            "Mnemonic is your secret data that allows you to access\nto your wallet. Always keep it safe and secure.\n\nAvailable shortcuts:\n- Tab or Enter: accept hint and move to the next field\n- Ctrl + V: paste mnemonic from clipboard"),
        "mnemonicQrReveal":
            MessageLookupByLibrary.simpleMessage("Reveal Mnemonic QR Code"),
        "mnemonicQrTip": MessageLookupByLibrary.simpleMessage(
            "Mnemonic QR Code is coded sentence of mnemonic words into QR."),
        "mnemonicQrWarning": MessageLookupByLibrary.simpleMessage(
            "You won’t be able to see it again"),
        "mnemonicSignIn":
            MessageLookupByLibrary.simpleMessage("Sign in with Mnemonic"),
        "mnemonicToastCopied": MessageLookupByLibrary.simpleMessage(
            "Mnemonic successfully copied"),
        "mnemonicWordsButtonCopy":
            MessageLookupByLibrary.simpleMessage("Copy mnemonic"),
        "mnemonicWordsReveal":
            MessageLookupByLibrary.simpleMessage("Reveal Mnemonic Words"),
        "mnemonicWordsSelectAmount":
            MessageLookupByLibrary.simpleMessage("Select the amount of words"),
        "mnemonicWordsTip": MessageLookupByLibrary.simpleMessage(
            "Mnemonic (“mnemonic code”, “seed phrase”, “seed words”)\nWay of representing a large randomly-generated number as a sequence of words,\nmaking it easier for humans to store."),
        "mnemonicWordsWarning": MessageLookupByLibrary.simpleMessage(
            "You won’t be able to see them again"),
        "myAccount": MessageLookupByLibrary.simpleMessage("My account"),
        "myAccountSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "myAccountSignOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
        "networkBlockHeight":
            MessageLookupByLibrary.simpleMessage("Block Height"),
        "networkBlockTime": MessageLookupByLibrary.simpleMessage("Block time"),
        "networkButtonArrowTip":
            MessageLookupByLibrary.simpleMessage("Go to the next page"),
        "networkButtonCancelConnection":
            MessageLookupByLibrary.simpleMessage("Cancel connection"),
        "networkButtonCheckConnection":
            MessageLookupByLibrary.simpleMessage("Check connection"),
        "networkButtonConnect": MessageLookupByLibrary.simpleMessage("Connect"),
        "networkButtonConnected":
            MessageLookupByLibrary.simpleMessage("Connected"),
        "networkButtonConnecting":
            MessageLookupByLibrary.simpleMessage("Connecting..."),
        "networkCheckedConnection":
            MessageLookupByLibrary.simpleMessage("Checked connection"),
        "networkChoose": MessageLookupByLibrary.simpleMessage("Choose network"),
        "networkConnectingTo": m3,
        "networkConnectionCancelled":
            MessageLookupByLibrary.simpleMessage("Connection cancelled"),
        "networkConnectionEstablished":
            MessageLookupByLibrary.simpleMessage("Connection established"),
        "networkErrorAddressEmpty":
            MessageLookupByLibrary.simpleMessage("Field can\'t be empty"),
        "networkErrorAddressInvalid":
            MessageLookupByLibrary.simpleMessage("Invalid network address"),
        "networkErrorCannotConnect":
            MessageLookupByLibrary.simpleMessage("Cannot connect to server"),
        "networkErrorUndefinedName":
            MessageLookupByLibrary.simpleMessage("undefined"),
        "networkHintCustomAddress":
            MessageLookupByLibrary.simpleMessage("Custom address"),
        "networkHowManyProblems": m4,
        "networkList": MessageLookupByLibrary.simpleMessage("List of networks"),
        "networkNoAvailable":
            MessageLookupByLibrary.simpleMessage("No available networks"),
        "networkOtherServers":
            MessageLookupByLibrary.simpleMessage("Other available servers:"),
        "networkProblemReason": MessageLookupByLibrary.simpleMessage(
            "Reason: Found problems with server you are trying to connect"),
        "networkSelectServers":
            MessageLookupByLibrary.simpleMessage("Select available servers"),
        "networkServerOffline": MessageLookupByLibrary.simpleMessage(
            "Selected server is offline\nPlease choose different server"),
        "networkServerOfflineReason":
            MessageLookupByLibrary.simpleMessage("Reason: Server is offline"),
        "networkServerToConnect": MessageLookupByLibrary.simpleMessage(
            "Server you are trying to connect:"),
        "networkSwitchCustomAddress":
            MessageLookupByLibrary.simpleMessage("Enable custom address"),
        "networkWarningIncompatible": MessageLookupByLibrary.simpleMessage(
            "The application is incompatible with this server. Some views may not work correctly."),
        "networkWarningWhenLastBlock": m5,
        "or": MessageLookupByLibrary.simpleMessage("or "),
        "paginatedListPageSize":
            MessageLookupByLibrary.simpleMessage("Page size"),
        "paste": MessageLookupByLibrary.simpleMessage("Paste"),
        "proposalTypeAssignPermissions":
            MessageLookupByLibrary.simpleMessage("Assign Permission"),
        "proposalTypeAssignRoleToAccount":
            MessageLookupByLibrary.simpleMessage("Assign Role To Account"),
        "proposalTypeBlacklistAccountPermission":
            MessageLookupByLibrary.simpleMessage(
                "Blacklist Account Permission"),
        "proposalTypeBlacklistRolePermission":
            MessageLookupByLibrary.simpleMessage("Blacklist Role Permission"),
        "proposalTypeCreateRole":
            MessageLookupByLibrary.simpleMessage("Create Role Proposal"),
        "proposalTypeRemoveBlacklistedAccountPermission":
            MessageLookupByLibrary.simpleMessage(
                "Remove Blacklisted Account Permission"),
        "proposalTypeRemoveBlacklistedRolePermission":
            MessageLookupByLibrary.simpleMessage(
                "Remove Blacklisted Role Permission"),
        "proposalTypeRemoveWhitelistedAccountPermission":
            MessageLookupByLibrary.simpleMessage(
                "Remove Whitelisted Account Permission"),
        "proposalTypeRemoveWhitelistedRolePermission":
            MessageLookupByLibrary.simpleMessage(
                "Remove Whitelisted Role Permission"),
        "proposalTypeResetWholeCouncilorRank":
            MessageLookupByLibrary.simpleMessage("Reset Whole Councilor Rank"),
        "proposalTypeSetNetworkProperty":
            MessageLookupByLibrary.simpleMessage("Set Network Property"),
        "proposalTypeSetPoorNetworkMessages":
            MessageLookupByLibrary.simpleMessage("Set Poor Network Messages"),
        "proposalTypeSetProposalDurations":
            MessageLookupByLibrary.simpleMessage("Set Proposal Durations"),
        "proposalTypeSoftwareUpgrade":
            MessageLookupByLibrary.simpleMessage("Software Upgrade"),
        "proposalTypeUnassignRoleFromAccount":
            MessageLookupByLibrary.simpleMessage("Unassign Role From Account"),
        "proposalTypeUpsertDataRegistry":
            MessageLookupByLibrary.simpleMessage("Upsert Data Registry"),
        "proposalTypeUpsertTokenAlias":
            MessageLookupByLibrary.simpleMessage("Upsert Token Alias"),
        "proposalTypeWhitelistAccountPermission":
            MessageLookupByLibrary.simpleMessage(
                "Whitelist Account Permission"),
        "proposalTypeWhitelistRolePermission":
            MessageLookupByLibrary.simpleMessage("Whitelist Role Permission"),
        "proposals": MessageLookupByLibrary.simpleMessage("Proposals"),
        "proposalsActive": MessageLookupByLibrary.simpleMessage("Active"),
        "proposalsEnacting": MessageLookupByLibrary.simpleMessage("Enacting"),
        "proposalsFinished": MessageLookupByLibrary.simpleMessage("Finished"),
        "proposalsProposers": MessageLookupByLibrary.simpleMessage("Proposers"),
        "proposalsSuccessful":
            MessageLookupByLibrary.simpleMessage("Successful"),
        "proposalsVoters": MessageLookupByLibrary.simpleMessage("Voters"),
        "sec": MessageLookupByLibrary.simpleMessage("sec."),
        "seeAll": MessageLookupByLibrary.simpleMessage("See all"),
        "seeMore": MessageLookupByLibrary.simpleMessage("See more"),
        "showDetails": MessageLookupByLibrary.simpleMessage("Show Details"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by"),
        "toastCannotLoadDashboard": MessageLookupByLibrary.simpleMessage(
            "Cannot load dashboard. Please check your connection."),
        "toastHashCopied":
            MessageLookupByLibrary.simpleMessage("Hash copied to clipboard"),
        "toastPublicAddressCopied":
            MessageLookupByLibrary.simpleMessage("Public address copied"),
        "toastSuccessfullyCopied":
            MessageLookupByLibrary.simpleMessage("Successfully copied"),
        "tx": MessageLookupByLibrary.simpleMessage("Transactions"),
        "txAvailableBalances": m6,
        "txButtonBackToAccount":
            MessageLookupByLibrary.simpleMessage("Back to account"),
        "txButtonClear": MessageLookupByLibrary.simpleMessage("Clear"),
        "txButtonConfirmSend":
            MessageLookupByLibrary.simpleMessage("Confirm & send"),
        "txButtonEdit": MessageLookupByLibrary.simpleMessage("Edit"),
        "txButtonEditTransaction":
            MessageLookupByLibrary.simpleMessage("Edit transaction"),
        "txButtonNext": MessageLookupByLibrary.simpleMessage("Next"),
        "txButtonSendAll": MessageLookupByLibrary.simpleMessage("Send all"),
        "txCompleted":
            MessageLookupByLibrary.simpleMessage("Transaction completed"),
        "txConfirm":
            MessageLookupByLibrary.simpleMessage("Confirm transaction"),
        "txDateDropdownAll": MessageLookupByLibrary.simpleMessage("All"),
        "txDateDropdownCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "txDateDropdownClear": MessageLookupByLibrary.simpleMessage("Clear"),
        "txDateDropdownEndDate":
            MessageLookupByLibrary.simpleMessage("End date"),
        "txDateDropdownOneMonth":
            MessageLookupByLibrary.simpleMessage("1 month"),
        "txDateDropdownOneWeek": MessageLookupByLibrary.simpleMessage("1 week"),
        "txDateDropdownSave": MessageLookupByLibrary.simpleMessage("Save"),
        "txDateDropdownStartDate":
            MessageLookupByLibrary.simpleMessage("Start date"),
        "txDateDropdownToday": MessageLookupByLibrary.simpleMessage("Today"),
        "txDateDropdownYesterday":
            MessageLookupByLibrary.simpleMessage("Yesterday"),
        "txErrorAccountNumberNotExist": MessageLookupByLibrary.simpleMessage(
            "Cannot create transaction. Deposit tokens to your account and try again."),
        "txErrorCannotCreate": MessageLookupByLibrary.simpleMessage(
            "Cannot create transaction. Check your connection."),
        "txErrorCannotFetchDetails": MessageLookupByLibrary.simpleMessage(
            "Cannot fetch transaction details. Check your internet connection."),
        "txErrorEnterValidAddress": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid address"),
        "txErrorFailed":
            MessageLookupByLibrary.simpleMessage("Transaction failed"),
        "txErrorHttpRequest": MessageLookupByLibrary.simpleMessage("Request"),
        "txErrorHttpResponse": MessageLookupByLibrary.simpleMessage("Response"),
        "txErrorNotEnoughTokens":
            MessageLookupByLibrary.simpleMessage("Not enough tokens"),
        "txErrorSeeMore":
            MessageLookupByLibrary.simpleMessage("See more on Explorer"),
        "txFetchingRemoteData": MessageLookupByLibrary.simpleMessage(
            "Fetching remote data. Please wait..."),
        "txHash": m7,
        "txHintMemo": MessageLookupByLibrary.simpleMessage("Memo"),
        "txHintSendFrom": MessageLookupByLibrary.simpleMessage("Send from"),
        "txHintSendTo": MessageLookupByLibrary.simpleMessage("Send to"),
        "txIsBeingBroadcast": MessageLookupByLibrary.simpleMessage(
            "Your transaction is being broadcast"),
        "txListAmount": MessageLookupByLibrary.simpleMessage("Amount"),
        "txListAmountFeesOnly":
            MessageLookupByLibrary.simpleMessage("Fees only"),
        "txListAmountPlusFees": MessageLookupByLibrary.simpleMessage("+ fees"),
        "txListAmountPlusMore": m8,
        "txListDate": MessageLookupByLibrary.simpleMessage("Date"),
        "txListDetails": MessageLookupByLibrary.simpleMessage("Details"),
        "txListDirection": MessageLookupByLibrary.simpleMessage("Direction"),
        "txListDirectionInbound":
            MessageLookupByLibrary.simpleMessage("Inbound"),
        "txListDirectionOutbound":
            MessageLookupByLibrary.simpleMessage("Outbound"),
        "txListFiltersTitle": MessageLookupByLibrary.simpleMessage("Filters"),
        "txListHash": MessageLookupByLibrary.simpleMessage("Transaction hash"),
        "txListStatus": MessageLookupByLibrary.simpleMessage("Status"),
        "txListStatusConfirmed":
            MessageLookupByLibrary.simpleMessage("Confirmed"),
        "txListStatusFailed": MessageLookupByLibrary.simpleMessage("Failed"),
        "txListStatusPending": MessageLookupByLibrary.simpleMessage("Pending"),
        "txMsgCancelIdentityRecordsVerifyRequest":
            MessageLookupByLibrary.simpleMessage("Cancel Verification Request"),
        "txMsgClaimRewards":
            MessageLookupByLibrary.simpleMessage("Claim Rewards"),
        "txMsgClaimUndelegation":
            MessageLookupByLibrary.simpleMessage("Claim Undelegation"),
        "txMsgDelegateTokens":
            MessageLookupByLibrary.simpleMessage("Delegate Tokens"),
        "txMsgDeleteIdentityRecords":
            MessageLookupByLibrary.simpleMessage("Delete Identity Records"),
        "txMsgHandleIdentityRecordsVerifyRequest":
            MessageLookupByLibrary.simpleMessage("Handle Verification Request"),
        "txMsgMulti": MessageLookupByLibrary.simpleMessage("Multi transaction"),
        "txMsgRegisterIdentityRecords":
            MessageLookupByLibrary.simpleMessage("Register Identity Records"),
        "txMsgRequestIdentityRecordsVerify":
            MessageLookupByLibrary.simpleMessage("Request Verification"),
        "txMsgSendReceiveTokens":
            MessageLookupByLibrary.simpleMessage("Receive"),
        "txMsgSendSendTokens": MessageLookupByLibrary.simpleMessage("Send"),
        "txMsgUndefined":
            MessageLookupByLibrary.simpleMessage("Unknown transaction type"),
        "txMsgUndelegateTokens":
            MessageLookupByLibrary.simpleMessage("Undelegate Tokens"),
        "txNoticeFee": m9,
        "txPleaseSelectToken":
            MessageLookupByLibrary.simpleMessage("Please select a token"),
        "txPreviewUnavailable": m10,
        "txRecipientWillGet":
            MessageLookupByLibrary.simpleMessage("Recipient will get"),
        "txSearchTokens": MessageLookupByLibrary.simpleMessage("Search tokens"),
        "txSendTokens": MessageLookupByLibrary.simpleMessage("Send tokens"),
        "txSigning":
            MessageLookupByLibrary.simpleMessage("Signing transaction"),
        "txToastHashCopied": MessageLookupByLibrary.simpleMessage(
            "Transaction hash copied to clipboard"),
        "txToken": MessageLookupByLibrary.simpleMessage("Token"),
        "txTotalAmount": MessageLookupByLibrary.simpleMessage("Total amount"),
        "txTryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
        "txWarningDoNotCloseWindow":
            MessageLookupByLibrary.simpleMessage("Do not close this window"),
        "txYouWillGet": MessageLookupByLibrary.simpleMessage("You will get"),
        "validators": MessageLookupByLibrary.simpleMessage("Validators"),
        "validatorsActive": MessageLookupByLibrary.simpleMessage("Active"),
        "validatorsButtonFilter": m11,
        "validatorsDropdownAll": MessageLookupByLibrary.simpleMessage("All"),
        "validatorsHintSearch":
            MessageLookupByLibrary.simpleMessage("Search validators"),
        "validatorsInactive": MessageLookupByLibrary.simpleMessage("Inactive"),
        "validatorsJailed": MessageLookupByLibrary.simpleMessage("Jailed"),
        "validatorsList":
            MessageLookupByLibrary.simpleMessage("List of Validators"),
        "validatorsPaused": MessageLookupByLibrary.simpleMessage("Paused"),
        "validatorsTableMoniker":
            MessageLookupByLibrary.simpleMessage("Moniker"),
        "validatorsTableStatus": MessageLookupByLibrary.simpleMessage("Status"),
        "validatorsTableStreak": MessageLookupByLibrary.simpleMessage("Streak"),
        "validatorsTableTop": MessageLookupByLibrary.simpleMessage("Top"),
        "validatorsTableUptime": MessageLookupByLibrary.simpleMessage("Uptime"),
        "validatorsTotal": MessageLookupByLibrary.simpleMessage("Total"),
        "validatorsWaiting": MessageLookupByLibrary.simpleMessage("Waiting")
      };
}
