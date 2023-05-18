// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Kira Network`
  String get kiraNetwork {
    return Intl.message(
      'Kira Network',
      name: 'kiraNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Balances`
  String get balances {
    return Intl.message(
      'Balances',
      name: 'balances',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get balancesButtonPay {
    return Intl.message(
      'Pay',
      name: 'balancesButtonPay',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get balancesButtonRequest {
    return Intl.message(
      'Request',
      name: 'balancesButtonRequest',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get balancesName {
    return Intl.message(
      'Name',
      name: 'balancesName',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get balancesAmount {
    return Intl.message(
      'Amount',
      name: 'balancesAmount',
      desc: '',
      args: [],
    );
  }

  /// `Denomination`
  String get balancesDenomination {
    return Intl.message(
      'Denomination',
      name: 'balancesDenomination',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get balancesSend {
    return Intl.message(
      'Send',
      name: 'balancesSend',
      desc: '',
      args: [],
    );
  }

  /// `Hide small balances`
  String get balancesHideSmall {
    return Intl.message(
      'Hide small balances',
      name: 'balancesHideSmall',
      desc: '',
      args: [],
    );
  }

  /// `Last block time: `
  String get balancesLastBlockTime {
    return Intl.message(
      'Last block time: ',
      name: 'balancesLastBlockTime',
      desc: '',
      args: [],
    );
  }

  /// `Search balances`
  String get balancesSearch {
    return Intl.message(
      'Search balances',
      name: 'balancesSearch',
      desc: '',
      args: [],
    );
  }

  /// ` ({time} minutes ago)`
  String balancesTimeSinceBlock(int time) {
    return Intl.message(
      ' ($time minutes ago)',
      name: 'balancesTimeSinceBlock',
      desc: '',
      args: [time],
    );
  }

  /// `Blocks`
  String get blocks {
    return Intl.message(
      'Blocks',
      name: 'blocks',
      desc: '',
      args: [],
    );
  }

  /// `Current height`
  String get blocksCurrentHeight {
    return Intl.message(
      'Current height',
      name: 'blocksCurrentHeight',
      desc: '',
      args: [],
    );
  }

  /// `Since genesis`
  String get blocksSinceGenesis {
    return Intl.message(
      'Since genesis',
      name: 'blocksSinceGenesis',
      desc: '',
      args: [],
    );
  }

  /// `Pending transactions`
  String get blocksPendingTransactions {
    return Intl.message(
      'Pending transactions',
      name: 'blocksPendingTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Current transactions`
  String get blocksCurrentTransactions {
    return Intl.message(
      'Current transactions',
      name: 'blocksCurrentTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Latest time`
  String get blocksLatestTime {
    return Intl.message(
      'Latest time',
      name: 'blocksLatestTime',
      desc: '',
      args: [],
    );
  }

  /// `Average time`
  String get blocksAverageTime {
    return Intl.message(
      'Average time',
      name: 'blocksAverageTime',
      desc: '',
      args: [],
    );
  }

  /// `Consensus`
  String get consensus {
    return Intl.message(
      'Consensus',
      name: 'consensus',
      desc: '',
      args: [],
    );
  }

  /// `Healthy`
  String get consensusHealthy {
    return Intl.message(
      'Healthy',
      name: 'consensusHealthy',
      desc: '',
      args: [],
    );
  }

  /// `Unhealthy`
  String get consensusUnhealthy {
    return Intl.message(
      'Unhealthy',
      name: 'consensusUnhealthy',
      desc: '',
      args: [],
    );
  }

  /// `Current Block Validator`
  String get consensusCurrentBlockValidator {
    return Intl.message(
      'Current Block Validator',
      name: 'consensusCurrentBlockValidator',
      desc: '',
      args: [],
    );
  }

  /// `Consensus state`
  String get consensusState {
    return Intl.message(
      'Consensus state',
      name: 'consensusState',
      desc: '',
      args: [],
    );
  }

  /// `Connect a Wallet`
  String get connectWallet {
    return Intl.message(
      'Connect a Wallet',
      name: 'connectWallet',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get connectWalletButtonSignIn {
    return Intl.message(
      'Sign in',
      name: 'connectWalletButtonSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Choose one of the following options:`
  String get connectWalletOptions {
    return Intl.message(
      'Choose one of the following options:',
      name: 'connectWalletOptions',
      desc: '',
      args: [],
    );
  }

  /// `Connecting into account...`
  String get connectWalletConnecting {
    return Intl.message(
      'Connecting into account...',
      name: 'connectWalletConnecting',
      desc: '',
      args: [],
    );
  }

  /// `Create a wallet`
  String get createWalletTitle {
    return Intl.message(
      'Create a wallet',
      name: 'createWalletTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create new wallet`
  String get createWalletButton {
    return Intl.message(
      'Create new wallet',
      name: 'createWalletButton',
      desc: '',
      args: [],
    );
  }

  /// `Generate\nnew address`
  String get createWalletButtonGenerateAddress {
    return Intl.message(
      'Generate\nnew address',
      name: 'createWalletButtonGenerateAddress',
      desc: '',
      args: [],
    );
  }

  /// `Your public address:`
  String get createWalletAddress {
    return Intl.message(
      'Your public address:',
      name: 'createWalletAddress',
      desc: '',
      args: [],
    );
  }

  /// `Generating...`
  String get createWalletAddressGenerating {
    return Intl.message(
      'Generating...',
      name: 'createWalletAddressGenerating',
      desc: '',
      args: [],
    );
  }

  /// `I understand that if I lose Mnemonic or Keyfile I will never have access to account again.`
  String get createWalletAcknowledgement {
    return Intl.message(
      'I understand that if I lose Mnemonic or Keyfile I will never have access to account again.',
      name: 'createWalletAcknowledgement',
      desc: '',
      args: [],
    );
  }

  /// `Don't have a wallet?`
  String get createWalletDontHave {
    return Intl.message(
      'Don\'t have a wallet?',
      name: 'createWalletDontHave',
      desc: '',
      args: [],
    );
  }

  /// `Keyfile`
  String get keyfile {
    return Intl.message(
      'Keyfile',
      name: 'keyfile',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get keyfileButtonDownload {
    return Intl.message(
      'Download',
      name: 'keyfileButtonDownload',
      desc: '',
      args: [],
    );
  }

  /// `Keyfile cannot be empty`
  String get keyfileErrorCannotBeEmpty {
    return Intl.message(
      'Keyfile cannot be empty',
      name: 'keyfileErrorCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get keyfileErrorPasswordsMatch {
    return Intl.message(
      'Passwords don\'t match',
      name: 'keyfileErrorPasswordsMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get keyfileHintPassword {
    return Intl.message(
      'Password',
      name: 'keyfileHintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Repeat password`
  String get keyfileHintRepeatPassword {
    return Intl.message(
      'Repeat password',
      name: 'keyfileHintRepeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Keyfile is a file which contains encrypted data.`
  String get keyfileTip {
    return Intl.message(
      'Keyfile is a file which contains encrypted data.',
      name: 'keyfileTip',
      desc: '',
      args: [],
    );
  }

  /// `Keyfile is your secret data`
  String get keyfileTipSecretData {
    return Intl.message(
      'Keyfile is your secret data',
      name: 'keyfileTipSecretData',
      desc: '',
      args: [],
    );
  }

  /// `Download Keyfile`
  String get keyfileTitleDownload {
    return Intl.message(
      'Download Keyfile',
      name: 'keyfileTitleDownload',
      desc: '',
      args: [],
    );
  }

  /// `Keyfile downloaded`
  String get keyfileToastDownloaded {
    return Intl.message(
      'Keyfile downloaded',
      name: 'keyfileToastDownloaded',
      desc: '',
      args: [],
    );
  }

  /// `You won’t be able to download it again`
  String get keyfileWarning {
    return Intl.message(
      'You won’t be able to download it again',
      name: 'keyfileWarning',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Keyfile`
  String get keyfileSignIn {
    return Intl.message(
      'Sign in with Keyfile',
      name: 'keyfileSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Drop Keyfile to the dropzone`
  String get keyfileToDropzone {
    return Intl.message(
      'Drop Keyfile to the dropzone',
      name: 'keyfileToDropzone',
      desc: '',
      args: [],
    );
  }

  /// `Please drop Keyfile here`
  String get keyfileDropHere {
    return Intl.message(
      'Please drop Keyfile here',
      name: 'keyfileDropHere',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get keyfileEnterPassword {
    return Intl.message(
      'Enter password',
      name: 'keyfileEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Keyfile`
  String get keyfileInvalid {
    return Intl.message(
      'Invalid Keyfile',
      name: 'keyfileInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get keyfileWrongPassword {
    return Intl.message(
      'Wrong password',
      name: 'keyfileWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create password for keyfile`
  String get keyfileCreatePassword {
    return Intl.message(
      'Create password for keyfile',
      name: 'keyfileCreatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Drop file`
  String get keyfileDropFile {
    return Intl.message(
      'Drop file',
      name: 'keyfileDropFile',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic`
  String get mnemonic {
    return Intl.message(
      'Mnemonic',
      name: 'mnemonic',
      desc: '',
      args: [],
    );
  }

  /// `Something unexpected happened`
  String get mnemonicErrorUnexpected {
    return Intl.message(
      'Something unexpected happened',
      name: 'mnemonicErrorUnexpected',
      desc: '',
      args: [],
    );
  }

  /// `You have to enter correct Mnemonic to sign in`
  String get mnemonicErrorEnterCorrect {
    return Intl.message(
      'You have to enter correct Mnemonic to sign in',
      name: 'mnemonicErrorEnterCorrect',
      desc: '',
      args: [],
    );
  }

  /// `Invalid mnemonic`
  String get mnemonicErrorInvalid {
    return Intl.message(
      'Invalid mnemonic',
      name: 'mnemonicErrorInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Invalid entropy`
  String get mnemonicErrorInvalidEntropy {
    return Intl.message(
      'Invalid entropy',
      name: 'mnemonicErrorInvalidEntropy',
      desc: '',
      args: [],
    );
  }

  /// `Invalid checksum`
  String get mnemonicErrorInvalidChecksum {
    return Intl.message(
      'Invalid checksum',
      name: 'mnemonicErrorInvalidChecksum',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic too short`
  String get mnemonicErrorTooShort {
    return Intl.message(
      'Mnemonic too short',
      name: 'mnemonicErrorTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic successfully copied`
  String get mnemonicToastCopied {
    return Intl.message(
      'Mnemonic successfully copied',
      name: 'mnemonicToastCopied',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Mnemonic`
  String get mnemonicSignIn {
    return Intl.message(
      'Sign in with Mnemonic',
      name: 'mnemonicSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Mnemonic`
  String get mnemonicEnter {
    return Intl.message(
      'Enter your Mnemonic',
      name: 'mnemonicEnter',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic is your secret data`
  String get mnemonicIsYourSecretData {
    return Intl.message(
      'Mnemonic is your secret data',
      name: 'mnemonicIsYourSecretData',
      desc: '',
      args: [],
    );
  }

  /// `Copy mnemonic`
  String get mnemonicWordsButtonCopy {
    return Intl.message(
      'Copy mnemonic',
      name: 'mnemonicWordsButtonCopy',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic (“mnemonic code”, “seed phrase”, “seed words”)\nWay of representing a large randomly-generated number as a sequence of words,\nmaking it easier for humans to store.`
  String get mnemonicWordsTip {
    return Intl.message(
      'Mnemonic (“mnemonic code”, “seed phrase”, “seed words”)\nWay of representing a large randomly-generated number as a sequence of words,\nmaking it easier for humans to store.',
      name: 'mnemonicWordsTip',
      desc: '',
      args: [],
    );
  }

  /// `You won’t be able to see them again`
  String get mnemonicWordsWarning {
    return Intl.message(
      'You won’t be able to see them again',
      name: 'mnemonicWordsWarning',
      desc: '',
      args: [],
    );
  }

  /// `Reveal Mnemonic Words`
  String get mnemonicWordsReveal {
    return Intl.message(
      'Reveal Mnemonic Words',
      name: 'mnemonicWordsReveal',
      desc: '',
      args: [],
    );
  }

  /// `Mnemonic QR Code is coded sentence of mnemonic words into QR.`
  String get mnemonicQrTip {
    return Intl.message(
      'Mnemonic QR Code is coded sentence of mnemonic words into QR.',
      name: 'mnemonicQrTip',
      desc: '',
      args: [],
    );
  }

  /// `You won’t be able to see it again`
  String get mnemonicQrWarning {
    return Intl.message(
      'You won’t be able to see it again',
      name: 'mnemonicQrWarning',
      desc: '',
      args: [],
    );
  }

  /// `Reveal Mnemonic QR Code`
  String get mnemonicQrReveal {
    return Intl.message(
      'Reveal Mnemonic QR Code',
      name: 'mnemonicQrReveal',
      desc: '',
      args: [],
    );
  }

  /// `My account`
  String get myAccount {
    return Intl.message(
      'My account',
      name: 'myAccount',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get myAccountSettings {
    return Intl.message(
      'Settings',
      name: 'myAccountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get myAccountSignOut {
    return Intl.message(
      'Sign Out',
      name: 'myAccountSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Cancel connection`
  String get networkButtonCancelConnection {
    return Intl.message(
      'Cancel connection',
      name: 'networkButtonCancelConnection',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get networkButtonConnect {
    return Intl.message(
      'Connect',
      name: 'networkButtonConnect',
      desc: '',
      args: [],
    );
  }

  /// `Connected`
  String get networkButtonConnected {
    return Intl.message(
      'Connected',
      name: 'networkButtonConnected',
      desc: '',
      args: [],
    );
  }

  /// `Check connection`
  String get networkButtonCheckConnection {
    return Intl.message(
      'Check connection',
      name: 'networkButtonCheckConnection',
      desc: '',
      args: [],
    );
  }

  /// `Connecting...`
  String get networkButtonConnecting {
    return Intl.message(
      'Connecting...',
      name: 'networkButtonConnecting',
      desc: '',
      args: [],
    );
  }

  /// `Go to the next page`
  String get networkButtonArrowTip {
    return Intl.message(
      'Go to the next page',
      name: 'networkButtonArrowTip',
      desc: '',
      args: [],
    );
  }

  /// `undefined`
  String get networkErrorUndefinedName {
    return Intl.message(
      'undefined',
      name: 'networkErrorUndefinedName',
      desc: '',
      args: [],
    );
  }

  /// `Cannot connect to server`
  String get networkErrorCannotConnect {
    return Intl.message(
      'Cannot connect to server',
      name: 'networkErrorCannotConnect',
      desc: '',
      args: [],
    );
  }

  /// `Field can't be empty`
  String get networkErrorAddressEmpty {
    return Intl.message(
      'Field can\'t be empty',
      name: 'networkErrorAddressEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid network address`
  String get networkErrorAddressInvalid {
    return Intl.message(
      'Invalid network address',
      name: 'networkErrorAddressInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Custom address`
  String get networkHintCustomAddress {
    return Intl.message(
      'Custom address',
      name: 'networkHintCustomAddress',
      desc: '',
      args: [],
    );
  }

  /// `The application is incompatible with this server. Some views may not work correctly.`
  String get networkWarningIncompatible {
    return Intl.message(
      'The application is incompatible with this server. Some views may not work correctly.',
      name: 'networkWarningIncompatible',
      desc: '',
      args: [],
    );
  }

  /// `The last available block on this interx was created long time ago {latestBlockTime}. The displayed contents may be out of date.`
  String networkWarningWhenLastBlock(String latestBlockTime) {
    return Intl.message(
      'The last available block on this interx was created long time ago $latestBlockTime. The displayed contents may be out of date.',
      name: 'networkWarningWhenLastBlock',
      desc: '',
      args: [latestBlockTime],
    );
  }

  /// `Select available servers`
  String get networkSelectServers {
    return Intl.message(
      'Select available servers',
      name: 'networkSelectServers',
      desc: '',
      args: [],
    );
  }

  /// `Connection cancelled`
  String get networkConnectionCancelled {
    return Intl.message(
      'Connection cancelled',
      name: 'networkConnectionCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Connection established`
  String get networkConnectionEstablished {
    return Intl.message(
      'Connection established',
      name: 'networkConnectionEstablished',
      desc: '',
      args: [],
    );
  }

  /// `Reason: Found problems with server you are trying to connect`
  String get networkProblemReason {
    return Intl.message(
      'Reason: Found problems with server you are trying to connect',
      name: 'networkProblemReason',
      desc: '',
      args: [],
    );
  }

  /// `Server you are trying to connect:`
  String get networkServerToConnect {
    return Intl.message(
      'Server you are trying to connect:',
      name: 'networkServerToConnect',
      desc: '',
      args: [],
    );
  }

  /// `Block time`
  String get networkBlockTime {
    return Intl.message(
      'Block time',
      name: 'networkBlockTime',
      desc: '',
      args: [],
    );
  }

  /// `Block Height`
  String get networkBlockHeight {
    return Intl.message(
      'Block Height',
      name: 'networkBlockHeight',
      desc: '',
      args: [],
    );
  }

  /// `Other available servers:`
  String get networkOtherServers {
    return Intl.message(
      'Other available servers:',
      name: 'networkOtherServers',
      desc: '',
      args: [],
    );
  }

  /// `No available networks`
  String get networkNoAvailable {
    return Intl.message(
      'No available networks',
      name: 'networkNoAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Enable custom address`
  String get networkSwitchCustomAddress {
    return Intl.message(
      'Enable custom address',
      name: 'networkSwitchCustomAddress',
      desc: '',
      args: [],
    );
  }

  /// `Checked connection`
  String get networkCheckedConnection {
    return Intl.message(
      'Checked connection',
      name: 'networkCheckedConnection',
      desc: '',
      args: [],
    );
  }

  /// `Reason: Server is offline`
  String get networkServerOfflineReason {
    return Intl.message(
      'Reason: Server is offline',
      name: 'networkServerOfflineReason',
      desc: '',
      args: [],
    );
  }

  /// `Selected server is offline\nPlease choose different server`
  String get networkServerOffline {
    return Intl.message(
      'Selected server is offline\nPlease choose different server',
      name: 'networkServerOffline',
      desc: '',
      args: [],
    );
  }

  /// `Choose network`
  String get networkChoose {
    return Intl.message(
      'Choose network',
      name: 'networkChoose',
      desc: '',
      args: [],
    );
  }

  /// `List of networks`
  String get networkList {
    return Intl.message(
      'List of networks',
      name: 'networkList',
      desc: '',
      args: [],
    );
  }

  /// `Found {errorsCount} problems with server`
  String networkHowManyProblems(int errorsCount) {
    return Intl.message(
      'Found $errorsCount problems with server',
      name: 'networkHowManyProblems',
      desc: '',
      args: [errorsCount],
    );
  }

  /// `Connecting to <{networkName}>{separator} Please wait... {parsedRemainingTime}`
  String networkConnectingTo(
      String separator, String networkName, String parsedRemainingTime) {
    return Intl.message(
      'Connecting to <$networkName>$separator Please wait... $parsedRemainingTime',
      name: 'networkConnectingTo',
      desc: '',
      args: [separator, networkName, parsedRemainingTime],
    );
  }

  /// `Proposals`
  String get proposals {
    return Intl.message(
      'Proposals',
      name: 'proposals',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get proposalsActive {
    return Intl.message(
      'Active',
      name: 'proposalsActive',
      desc: '',
      args: [],
    );
  }

  /// `Enacting`
  String get proposalsEnacting {
    return Intl.message(
      'Enacting',
      name: 'proposalsEnacting',
      desc: '',
      args: [],
    );
  }

  /// `Finished`
  String get proposalsFinished {
    return Intl.message(
      'Finished',
      name: 'proposalsFinished',
      desc: '',
      args: [],
    );
  }

  /// `Successful`
  String get proposalsSuccessful {
    return Intl.message(
      'Successful',
      name: 'proposalsSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Proposers`
  String get proposalsProposers {
    return Intl.message(
      'Proposers',
      name: 'proposalsProposers',
      desc: '',
      args: [],
    );
  }

  /// `Voters`
  String get proposalsVoters {
    return Intl.message(
      'Voters',
      name: 'proposalsVoters',
      desc: '',
      args: [],
    );
  }

  /// `Transactions`
  String get tx {
    return Intl.message(
      'Transactions',
      name: 'tx',
      desc: '',
      args: [],
    );
  }

  /// `Send all`
  String get txButtonSendAll {
    return Intl.message(
      'Send all',
      name: 'txButtonSendAll',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get txButtonClear {
    return Intl.message(
      'Clear',
      name: 'txButtonClear',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get txButtonNext {
    return Intl.message(
      'Next',
      name: 'txButtonNext',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get txButtonEdit {
    return Intl.message(
      'Edit',
      name: 'txButtonEdit',
      desc: '',
      args: [],
    );
  }

  /// `Confirm & send`
  String get txButtonConfirmSend {
    return Intl.message(
      'Confirm & send',
      name: 'txButtonConfirmSend',
      desc: '',
      args: [],
    );
  }

  /// `Back to account`
  String get txButtonBackToAccount {
    return Intl.message(
      'Back to account',
      name: 'txButtonBackToAccount',
      desc: '',
      args: [],
    );
  }

  /// `Edit transaction`
  String get txButtonEditTransaction {
    return Intl.message(
      'Edit transaction',
      name: 'txButtonEditTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Not enough tokens`
  String get txErrorNotEnoughTokens {
    return Intl.message(
      'Not enough tokens',
      name: 'txErrorNotEnoughTokens',
      desc: '',
      args: [],
    );
  }

  /// `Cannot create transaction. Check your connection.`
  String get txErrorCannotCreate {
    return Intl.message(
      'Cannot create transaction. Check your connection.',
      name: 'txErrorCannotCreate',
      desc: '',
      args: [],
    );
  }

  /// `Cannot fetch transaction details. Check your internet connection.`
  String get txErrorCannotFetchDetails {
    return Intl.message(
      'Cannot fetch transaction details. Check your internet connection.',
      name: 'txErrorCannotFetchDetails',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid address`
  String get txErrorEnterValidAddress {
    return Intl.message(
      'Please enter a valid address',
      name: 'txErrorEnterValidAddress',
      desc: '',
      args: [],
    );
  }

  /// `Transaction failed`
  String get txErrorFailed {
    return Intl.message(
      'Transaction failed',
      name: 'txErrorFailed',
      desc: '',
      args: [],
    );
  }

  /// `See more on Explorer`
  String get txErrorSeeMore {
    return Intl.message(
      'See more on Explorer',
      name: 'txErrorSeeMore',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get txErrorHttpRequest {
    return Intl.message(
      'Request',
      name: 'txErrorHttpRequest',
      desc: '',
      args: [],
    );
  }

  /// `Response`
  String get txErrorHttpResponse {
    return Intl.message(
      'Response',
      name: 'txErrorHttpResponse',
      desc: '',
      args: [],
    );
  }

  /// `Send from`
  String get txHintSendFrom {
    return Intl.message(
      'Send from',
      name: 'txHintSendFrom',
      desc: '',
      args: [],
    );
  }

  /// `Send to`
  String get txHintSendTo {
    return Intl.message(
      'Send to',
      name: 'txHintSendTo',
      desc: '',
      args: [],
    );
  }

  /// `Memo`
  String get txHintMemo {
    return Intl.message(
      'Memo',
      name: 'txHintMemo',
      desc: '',
      args: [],
    );
  }

  /// `Transaction fee {widgetFeeTokenAmountModel}`
  String txNoticeFee(String widgetFeeTokenAmountModel) {
    return Intl.message(
      'Transaction fee $widgetFeeTokenAmountModel',
      name: 'txNoticeFee',
      desc: '',
      args: [widgetFeeTokenAmountModel],
    );
  }

  /// `Try again`
  String get txTryAgain {
    return Intl.message(
      'Try again',
      name: 'txTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Fetching remote data. Please wait...`
  String get txFetchingRemoteData {
    return Intl.message(
      'Fetching remote data. Please wait...',
      name: 'txFetchingRemoteData',
      desc: '',
      args: [],
    );
  }

  /// `Send tokens`
  String get txSendTokens {
    return Intl.message(
      'Send tokens',
      name: 'txSendTokens',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get txTotalAmount {
    return Intl.message(
      'Total amount',
      name: 'txTotalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Recipient will get`
  String get txRecipientWillGet {
    return Intl.message(
      'Recipient will get',
      name: 'txRecipientWillGet',
      desc: '',
      args: [],
    );
  }

  /// `Signing transaction`
  String get txSigning {
    return Intl.message(
      'Signing transaction',
      name: 'txSigning',
      desc: '',
      args: [],
    );
  }

  /// `Search tokens`
  String get txSearchTokens {
    return Intl.message(
      'Search tokens',
      name: 'txSearchTokens',
      desc: '',
      args: [],
    );
  }

  /// `Confirm transaction`
  String get txConfirm {
    return Intl.message(
      'Confirm transaction',
      name: 'txConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Your transaction is being broadcast`
  String get txIsBeingBroadcast {
    return Intl.message(
      'Your transaction is being broadcast',
      name: 'txIsBeingBroadcast',
      desc: '',
      args: [],
    );
  }

  /// `Do not close this window`
  String get txWarningDoNotCloseWindow {
    return Intl.message(
      'Do not close this window',
      name: 'txWarningDoNotCloseWindow',
      desc: '',
      args: [],
    );
  }

  /// `Transaction completed`
  String get txCompleted {
    return Intl.message(
      'Transaction completed',
      name: 'txCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Transaction hash copied to clipboard`
  String get txToastHashCopied {
    return Intl.message(
      'Transaction hash copied to clipboard',
      name: 'txToastHashCopied',
      desc: '',
      args: [],
    );
  }

  /// `Token`
  String get txToken {
    return Intl.message(
      'Token',
      name: 'txToken',
      desc: '',
      args: [],
    );
  }

  /// `Please select a token`
  String get txPleaseSelectToken {
    return Intl.message(
      'Please select a token',
      name: 'txPleaseSelectToken',
      desc: '',
      args: [],
    );
  }

  /// `Transaction hash: 0x{hash}`
  String txHash(String hash) {
    return Intl.message(
      'Transaction hash: 0x$hash',
      name: 'txHash',
      desc: '',
      args: [hash],
    );
  }

  /// `Available: {availableAmountText} {tokenDenominationModelName}`
  String txAvailableBalances(
      String availableAmountText, String tokenDenominationModelName) {
    return Intl.message(
      'Available: $availableAmountText $tokenDenominationModelName',
      name: 'txAvailableBalances',
      desc: '',
      args: [availableAmountText, tokenDenominationModelName],
    );
  }

  /// `Preview for {txMsgType} unavailable`
  String txPreviewUnavailable(String txMsgType) {
    return Intl.message(
      'Preview for $txMsgType unavailable',
      name: 'txPreviewUnavailable',
      desc: '',
      args: [txMsgType],
    );
  }

  /// `Validators`
  String get validators {
    return Intl.message(
      'Validators',
      name: 'validators',
      desc: '',
      args: [],
    );
  }

  /// `{selected} selected`
  String validatorsButtonFilter(int selected) {
    return Intl.message(
      '$selected selected',
      name: 'validatorsButtonFilter',
      desc: '',
      args: [selected],
    );
  }

  /// `Search validators`
  String get validatorsHintSearch {
    return Intl.message(
      'Search validators',
      name: 'validatorsHintSearch',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get validatorsTotal {
    return Intl.message(
      'Total',
      name: 'validatorsTotal',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get validatorsActive {
    return Intl.message(
      'Active',
      name: 'validatorsActive',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get validatorsInactive {
    return Intl.message(
      'Inactive',
      name: 'validatorsInactive',
      desc: '',
      args: [],
    );
  }

  /// `Jailed`
  String get validatorsJailed {
    return Intl.message(
      'Jailed',
      name: 'validatorsJailed',
      desc: '',
      args: [],
    );
  }

  /// `Paused`
  String get validatorsPaused {
    return Intl.message(
      'Paused',
      name: 'validatorsPaused',
      desc: '',
      args: [],
    );
  }

  /// `Waiting`
  String get validatorsWaiting {
    return Intl.message(
      'Waiting',
      name: 'validatorsWaiting',
      desc: '',
      args: [],
    );
  }

  /// `List of Validators`
  String get validatorsList {
    return Intl.message(
      'List of Validators',
      name: 'validatorsList',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get validatorsDropdownAll {
    return Intl.message(
      'All',
      name: 'validatorsDropdownAll',
      desc: '',
      args: [],
    );
  }

  /// `Top`
  String get validatorsTableTop {
    return Intl.message(
      'Top',
      name: 'validatorsTableTop',
      desc: '',
      args: [],
    );
  }

  /// `Moniker`
  String get validatorsTableMoniker {
    return Intl.message(
      'Moniker',
      name: 'validatorsTableMoniker',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get validatorsTableStatus {
    return Intl.message(
      'Status',
      name: 'validatorsTableStatus',
      desc: '',
      args: [],
    );
  }

  /// `Uptime`
  String get validatorsTableUptime {
    return Intl.message(
      'Uptime',
      name: 'validatorsTableUptime',
      desc: '',
      args: [],
    );
  }

  /// `Streak`
  String get validatorsTableStreak {
    return Intl.message(
      'Streak',
      name: 'validatorsTableStreak',
      desc: '',
      args: [],
    );
  }

  /// `Report issues`
  String get buttonReportIssues {
    return Intl.message(
      'Report issues',
      name: 'buttonReportIssues',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Undefined error`
  String get errorUndefined {
    return Intl.message(
      'Undefined error',
      name: 'errorUndefined',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get errorUnknown {
    return Intl.message(
      'Unknown error',
      name: 'errorUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Error explorer`
  String get errorExplorer {
    return Intl.message(
      'Error explorer',
      name: 'errorExplorer',
      desc: '',
      args: [],
    );
  }

  /// `No results`
  String get errorNoResults {
    return Intl.message(
      'No results',
      name: 'errorNoResults',
      desc: '',
      args: [],
    );
  }

  /// `Cannot fetch data`
  String get errorCannotFetchData {
    return Intl.message(
      'Cannot fetch data',
      name: 'errorCannotFetchData',
      desc: '',
      args: [],
    );
  }

  /// `Preview not available`
  String get errorPreviewNotAvailable {
    return Intl.message(
      'Preview not available',
      name: 'errorPreviewNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Successfully copied`
  String get toastSuccessfullyCopied {
    return Intl.message(
      'Successfully copied',
      name: 'toastSuccessfullyCopied',
      desc: '',
      args: [],
    );
  }

  /// `Public address copied to clipboard`
  String get toastPublicAddressCopied {
    return Intl.message(
      'Public address copied to clipboard',
      name: 'toastPublicAddressCopied',
      desc: '',
      args: [],
    );
  }

  /// `Cannot load dashboard. Please check your connection.`
  String get toastCannotLoadDashboard {
    return Intl.message(
      'Cannot load dashboard. Please check your connection.',
      name: 'toastCannotLoadDashboard',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Governance`
  String get governance {
    return Intl.message(
      'Governance',
      name: 'governance',
      desc: '',
      args: [],
    );
  }

  /// `Accounts`
  String get accounts {
    return Intl.message(
      'Accounts',
      name: 'accounts',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message(
      'Sort by',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `sec.`
  String get sec {
    return Intl.message(
      'sec.',
      name: 'sec',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `or `
  String get or {
    return Intl.message(
      'or ',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `browse`
  String get browse {
    return Intl.message(
      'browse',
      name: 'browse',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
