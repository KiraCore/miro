// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
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
  String get localeName => 'pl';

  static String m0(time) => " (${time} minut temu)";

  static String m3(separator, networkName, parsedRemainingTime) =>
      "Łączenie z <${networkName}>${separator} Proszę czekać... ${parsedRemainingTime}";

  static String m4(errorsCount) =>
      "${Intl.plural(errorsCount, one: 'Znaleziono ${errorsCount} problem z serwerem', few: 'Znaleziono ${errorsCount} problemy z serwerem', other: 'Znaleziono ${errorsCount} problemów z serwerem')}";

  static String m5(latestBlockTime) =>
      "Ostatni dostępny blok na tym interx został utworzony ${latestBlockTime}. Wyświetlane dane mogą być nieaktualne.";

  static String m7(availableAmountText, tokenDenominationModelName) =>
      "Dostępne: ${availableAmountText} ${tokenDenominationModelName}";

  static String m8(hash) => "Hash transakcji: 0x${hash}";

  static String m9(amount) => "+ ${amount} więcej";

  static String m10(widgetFeeTokenAmountModel) =>
      "Opłata za transakcję ${widgetFeeTokenAmountModel}";

  static String m11(txMsgType) => "Podgląd dla \$${txMsgType} niedostępny";

  static String m12(selected) => "${selected} wybrano";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accounts": MessageLookupByLibrary.simpleMessage("Konta"),
        "balances": MessageLookupByLibrary.simpleMessage("Zasoby"),
        "balancesAmount": MessageLookupByLibrary.simpleMessage("Kwota"),
        "balancesButtonPay": MessageLookupByLibrary.simpleMessage("Zapłać"),
        "balancesButtonRequest":
            MessageLookupByLibrary.simpleMessage("Generuj QR"),
        "balancesDenomination":
            MessageLookupByLibrary.simpleMessage("Denominacja"),
        "balancesHideSmall":
            MessageLookupByLibrary.simpleMessage("Ukryj niskie zasoby"),
        "balancesLastBlockTime":
            MessageLookupByLibrary.simpleMessage("Czas ostatniego bloku: "),
        "balancesName": MessageLookupByLibrary.simpleMessage("Nazwa"),
        "balancesSearch":
            MessageLookupByLibrary.simpleMessage("Szukaj zasobów"),
        "balancesSend": MessageLookupByLibrary.simpleMessage("Wyślij"),
        "balancesTimeSinceBlock": m0,
        "blocks": MessageLookupByLibrary.simpleMessage("Bloki"),
        "blocksAverageTime":
            MessageLookupByLibrary.simpleMessage("Średni czas"),
        "blocksCurrentHeight":
            MessageLookupByLibrary.simpleMessage("Aktualna wysokość"),
        "blocksCurrentTransactions":
            MessageLookupByLibrary.simpleMessage("Aktualne transakcje"),
        "blocksLatestTime":
            MessageLookupByLibrary.simpleMessage("Ostatni czas"),
        "blocksPendingTransactions":
            MessageLookupByLibrary.simpleMessage("Transakcje w toku"),
        "blocksSinceGenesis":
            MessageLookupByLibrary.simpleMessage("Od początku"),
        "browse": MessageLookupByLibrary.simpleMessage("przeglądaj"),
        "buttonReportIssues":
            MessageLookupByLibrary.simpleMessage("Zgłoś problem"),
        "connectWallet":
            MessageLookupByLibrary.simpleMessage("Podłącz portfel"),
        "connectWalletButtonSignIn":
            MessageLookupByLibrary.simpleMessage("Zaloguj się"),
        "connectWalletConnecting":
            MessageLookupByLibrary.simpleMessage("Łączenie z kontem..."),
        "connectWalletOptions": MessageLookupByLibrary.simpleMessage(
            "Wybierz jedną z poniższych opcji:"),
        "consensus": MessageLookupByLibrary.simpleMessage("Konsensus"),
        "consensusCurrentBlockValidator":
            MessageLookupByLibrary.simpleMessage("Aktualny walidator bloków"),
        "consensusHealthy": MessageLookupByLibrary.simpleMessage("Zdrowy"),
        "consensusState":
            MessageLookupByLibrary.simpleMessage("Stan konsensusu"),
        "consensusUnhealthy": MessageLookupByLibrary.simpleMessage("Niezdrowy"),
        "copy": MessageLookupByLibrary.simpleMessage("Kopiuj"),
        "createWalletAcknowledgement": MessageLookupByLibrary.simpleMessage(
            "Rozumiem, że w przypadku utraty Mnemoniki lub Keyfile\'a, dostęp do konta zostanie na zawsze utracony."),
        "createWalletAddress":
            MessageLookupByLibrary.simpleMessage("Twój adres publiczny:"),
        "createWalletAddressGenerating":
            MessageLookupByLibrary.simpleMessage("Generowanie..."),
        "createWalletButton":
            MessageLookupByLibrary.simpleMessage("Utwórz nowy portfel"),
        "createWalletButtonGenerateAddress":
            MessageLookupByLibrary.simpleMessage("Generuj\nnowy adres"),
        "createWalletDontHave":
            MessageLookupByLibrary.simpleMessage("Nie masz portfela?"),
        "createWalletTitle":
            MessageLookupByLibrary.simpleMessage("Utwórz portfel"),
        "dashboard": MessageLookupByLibrary.simpleMessage("Panel"),
        "error": MessageLookupByLibrary.simpleMessage("Błąd"),
        "errorCannotFetchData":
            MessageLookupByLibrary.simpleMessage("Nie można pobrać danych"),
        "errorExplorer":
            MessageLookupByLibrary.simpleMessage("Eksplorator błędów"),
        "errorNoResults": MessageLookupByLibrary.simpleMessage("Brak wyników"),
        "errorPreviewNotAvailable":
            MessageLookupByLibrary.simpleMessage("Podgląd niedostępny"),
        "errorUndefined":
            MessageLookupByLibrary.simpleMessage("Niezdefiniowany błąd"),
        "errorUnknown": MessageLookupByLibrary.simpleMessage("Nieznany błąd"),
        "governance": MessageLookupByLibrary.simpleMessage("Komitet"),
        "ir": MessageLookupByLibrary.simpleMessage("Rejestr Tożsamości"),
        "irAvatar": MessageLookupByLibrary.simpleMessage("Awatar"),
        "irDescription": MessageLookupByLibrary.simpleMessage("Opis"),
        "irEntries": MessageLookupByLibrary.simpleMessage("Pozycje"),
        "irRecordAdd": MessageLookupByLibrary.simpleMessage("Dodaj"),
        "irRecordDelete": MessageLookupByLibrary.simpleMessage("Usuń"),
        "irRecordEdit": MessageLookupByLibrary.simpleMessage("Edytuj"),
        "irRecordStatus": MessageLookupByLibrary.simpleMessage("Status"),
        "irRecordStatusNotVerified":
            MessageLookupByLibrary.simpleMessage("Nie zweryfikowano"),
        "irRecordStatusPending":
            MessageLookupByLibrary.simpleMessage("W trakcie"),
        "irRecordVerify": MessageLookupByLibrary.simpleMessage("Zweryfikuj"),
        "irSocialMedia": MessageLookupByLibrary.simpleMessage("Social media"),
        "irUsername": MessageLookupByLibrary.simpleMessage("Nazwa użytkownika"),
        "keyfile": MessageLookupByLibrary.simpleMessage("Keyfile"),
        "keyfileButtonDownload":
            MessageLookupByLibrary.simpleMessage("Pobierz"),
        "keyfileCreatePassword":
            MessageLookupByLibrary.simpleMessage("Utwórz hasło do Keyfile\'a"),
        "keyfileDropFile":
            MessageLookupByLibrary.simpleMessage("Przeciągnij plik"),
        "keyfileDropHere": MessageLookupByLibrary.simpleMessage(
            "Przeciągnij plik do okna poniżej"),
        "keyfileEnterPassword":
            MessageLookupByLibrary.simpleMessage("Wpisz hasło"),
        "keyfileHintPassword": MessageLookupByLibrary.simpleMessage("Hasło"),
        "keyfileHintRepeatPassword":
            MessageLookupByLibrary.simpleMessage("Powtórz hasło"),
        "keyfileInvalid":
            MessageLookupByLibrary.simpleMessage("Nieprawidłowy plik"),
        "keyfileSignIn":
            MessageLookupByLibrary.simpleMessage("Zaloguj się Keyfile\'em"),
        "keyfileTip": MessageLookupByLibrary.simpleMessage(
            "Keyfile to plik, który zawiera zaszyfrowane dane."),
        "keyfileTipSecretData": MessageLookupByLibrary.simpleMessage(
            "Keyfile zawiera Twoje poufne dane"),
        "keyfileTitleDownload":
            MessageLookupByLibrary.simpleMessage("Pobierz Keyfile"),
        "keyfileToDropzone": MessageLookupByLibrary.simpleMessage(
            "Przeciągnij Keyfile do tego pola"),
        "keyfileWarning": MessageLookupByLibrary.simpleMessage(
            "Nie będziesz mieć możliwości pobrania go ponownie"),
        "keyfileWrongPassword":
            MessageLookupByLibrary.simpleMessage("Nieprawidłowe hasło"),
        "kiraNetwork": MessageLookupByLibrary.simpleMessage("Kira Network"),
        "language": MessageLookupByLibrary.simpleMessage("Polski"),
        "mnemonic": MessageLookupByLibrary.simpleMessage("Mnemonik"),
        "mnemonicEnter": MessageLookupByLibrary.simpleMessage("Wpisz Mnemonik"),
        "mnemonicErrorEnterCorrect": MessageLookupByLibrary.simpleMessage(
            "Musisz wpisać Mnemonik poprawnie, aby się zalogować"),
        "mnemonicErrorInvalid":
            MessageLookupByLibrary.simpleMessage("Nieprawidłowy mnemonik"),
        "mnemonicErrorInvalidChecksum":
            MessageLookupByLibrary.simpleMessage("Nieprawidłowa suma"),
        "mnemonicErrorTooShort":
            MessageLookupByLibrary.simpleMessage("Mnemonik zbyt krótki"),
        "mnemonicErrorUnexpected":
            MessageLookupByLibrary.simpleMessage("Coś poszło nie tak"),
        "mnemonicQrReveal":
            MessageLookupByLibrary.simpleMessage("Pokaż Mnemonik jako kod QR"),
        "mnemonicQrTip": MessageLookupByLibrary.simpleMessage(
            "Wygenerowany kod QR reprezentuje wartość Mnemonika."),
        "mnemonicQrWarning": MessageLookupByLibrary.simpleMessage(
            "Nie będziesz mieć możliwości wyświetlenia go ponownie"),
        "mnemonicSignIn":
            MessageLookupByLibrary.simpleMessage("Zaloguj się Mnemonikiem"),
        "mnemonicToastCopied": MessageLookupByLibrary.simpleMessage(
            "Pomyślnie skopiowano mnemonik"),
        "mnemonicWordsButtonCopy":
            MessageLookupByLibrary.simpleMessage("Kopiuj mnemonik"),
        "mnemonicWordsReveal":
            MessageLookupByLibrary.simpleMessage("Pokaż Mnemonik"),
        "mnemonicWordsTip": MessageLookupByLibrary.simpleMessage(
            "Mnemonik (“mnemonic code”, “seed phrase”, “seed words”)\nSposób przedstawienia dużej, losowo wygenerowanej liczby jako ciągu słów,\nułatwiając użytkownikowi przechowywanie tej liczby."),
        "mnemonicWordsWarning": MessageLookupByLibrary.simpleMessage(
            "Nie będziesz mieć możliwości wyświetlenia go ponownie"),
        "myAccount": MessageLookupByLibrary.simpleMessage("Moje konto"),
        "myAccountSettings": MessageLookupByLibrary.simpleMessage("Ustawienia"),
        "myAccountSignOut": MessageLookupByLibrary.simpleMessage("Wyloguj się"),
        "networkBlockHeight":
            MessageLookupByLibrary.simpleMessage("Wysokość bloku"),
        "networkBlockTime":
            MessageLookupByLibrary.simpleMessage("Czas utworzenia bloku"),
        "networkButtonArrowTip":
            MessageLookupByLibrary.simpleMessage("Przejdź do następnej strony"),
        "networkButtonCancelConnection":
            MessageLookupByLibrary.simpleMessage("Przerwij połączenie"),
        "networkButtonCheckConnection":
            MessageLookupByLibrary.simpleMessage("Sprawdź połączenie"),
        "networkButtonConnect": MessageLookupByLibrary.simpleMessage("Połącz"),
        "networkButtonConnected":
            MessageLookupByLibrary.simpleMessage("Połączono"),
        "networkButtonConnecting":
            MessageLookupByLibrary.simpleMessage("Łączenie..."),
        "networkCheckedConnection":
            MessageLookupByLibrary.simpleMessage("Sprawdzany serwer"),
        "networkChoose": MessageLookupByLibrary.simpleMessage("Wybierz sieć"),
        "networkConnectingTo": m3,
        "networkConnectionCancelled":
            MessageLookupByLibrary.simpleMessage("Przerwano połączenie"),
        "networkConnectionEstablished":
            MessageLookupByLibrary.simpleMessage("Połączono"),
        "networkErrorAddressEmpty":
            MessageLookupByLibrary.simpleMessage("Pola nie mogą być puste"),
        "networkErrorAddressInvalid":
            MessageLookupByLibrary.simpleMessage("Nieprawidłowy adres sieci"),
        "networkErrorCannotConnect": MessageLookupByLibrary.simpleMessage(
            "Nie można połączyć z serwerem"),
        "networkErrorUndefinedName":
            MessageLookupByLibrary.simpleMessage("nie zdefiniowano"),
        "networkHintCustomAddress":
            MessageLookupByLibrary.simpleMessage("Niestandardowy adres"),
        "networkHowManyProblems": m4,
        "networkList": MessageLookupByLibrary.simpleMessage("Lista sieci"),
        "networkNoAvailable":
            MessageLookupByLibrary.simpleMessage("Brak dostępnych sieci"),
        "networkOtherServers":
            MessageLookupByLibrary.simpleMessage("Inne dostępne serwery:"),
        "networkProblemReason": MessageLookupByLibrary.simpleMessage(
            "Powód: Znaleziono problemy z serwerem, z którym próbujesz się połączyć"),
        "networkSelectServers":
            MessageLookupByLibrary.simpleMessage("Wybierz dostępne serwery"),
        "networkServerOffline": MessageLookupByLibrary.simpleMessage(
            "Wybrany serwer jest offline\nProszę wybrać inny serwer"),
        "networkServerOfflineReason":
            MessageLookupByLibrary.simpleMessage("Powód: Serwer jest offline"),
        "networkServerToConnect": MessageLookupByLibrary.simpleMessage(
            "Serwer do którego próbujesz się połączyć:"),
        "networkSwitchCustomAddress":
            MessageLookupByLibrary.simpleMessage("Niestandardowy adres"),
        "networkWarningIncompatible": MessageLookupByLibrary.simpleMessage(
            "Aplikacja nie jest kompatybilna z tym serwerem. Niektóre sekcje mogą nie działać poprawnie."),
        "networkWarningWhenLastBlock": m5,
        "or": MessageLookupByLibrary.simpleMessage("lub "),
        "paginatedListPageSize":
            MessageLookupByLibrary.simpleMessage("Ilość wyników"),
        "proposals": MessageLookupByLibrary.simpleMessage("Wnioski"),
        "proposalsActive": MessageLookupByLibrary.simpleMessage("Aktywne"),
        "proposalsEnacting": MessageLookupByLibrary.simpleMessage("Uchwalane"),
        "proposalsFinished": MessageLookupByLibrary.simpleMessage("Zakończone"),
        "proposalsProposers":
            MessageLookupByLibrary.simpleMessage("Proponenci"),
        "proposalsSuccessful": MessageLookupByLibrary.simpleMessage("Pomyślne"),
        "proposalsVoters": MessageLookupByLibrary.simpleMessage("Głosujący"),
        "sec": MessageLookupByLibrary.simpleMessage("sek."),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sortuj według"),
        "toastCannotLoadDashboard": MessageLookupByLibrary.simpleMessage(
            "Nie można załadować strony. Sprawdź swoje połączenie z siecią."),
        "toastHashCopied":
            MessageLookupByLibrary.simpleMessage("Hash pomyślnie skopiowano"),
        "toastPublicAddressCopied": MessageLookupByLibrary.simpleMessage(
            "Adres publiczny skopiowany do schowka"),
        "toastSuccessfullyCopied":
            MessageLookupByLibrary.simpleMessage("Pomyślnie skopiowano"),
        "tx": MessageLookupByLibrary.simpleMessage("Transakcje"),
        "txAvailableBalances": m7,
        "txButtonBackToAccount":
            MessageLookupByLibrary.simpleMessage("Powrót do konta"),
        "txButtonClear": MessageLookupByLibrary.simpleMessage("Wyczyść"),
        "txButtonConfirmSend":
            MessageLookupByLibrary.simpleMessage("Potwierdź i wyślij"),
        "txButtonEdit": MessageLookupByLibrary.simpleMessage("Edytuj"),
        "txButtonEditTransaction":
            MessageLookupByLibrary.simpleMessage("Edytuj transakcję"),
        "txButtonNext": MessageLookupByLibrary.simpleMessage("Następny"),
        "txButtonSendAll":
            MessageLookupByLibrary.simpleMessage("Wyślij wszystkie"),
        "txCompleted":
            MessageLookupByLibrary.simpleMessage("Transakcja zakończona"),
        "txConfirm":
            MessageLookupByLibrary.simpleMessage("Potwierdź transakcję"),
        "txErrorCannotCreate": MessageLookupByLibrary.simpleMessage(
            "Nie można utworzyć transakcji. Proszę sprawdzić połączenie z siecią."),
        "txErrorCannotFetchDetails": MessageLookupByLibrary.simpleMessage(
            "Cannot fetch transaction details. Check your internet connection."),
        "txErrorEnterValidAddress": MessageLookupByLibrary.simpleMessage(
            "Proszę wpisać poprawny adres"),
        "txErrorFailed":
            MessageLookupByLibrary.simpleMessage("Transakcja nie powiodła się"),
        "txErrorHttpRequest": MessageLookupByLibrary.simpleMessage("Zapytanie"),
        "txErrorHttpResponse":
            MessageLookupByLibrary.simpleMessage("Odpowiedź"),
        "txErrorNotEnoughTokens": MessageLookupByLibrary.simpleMessage(
            "Niewystarczająca ilość tokenów"),
        "txErrorSeeMore": MessageLookupByLibrary.simpleMessage(
            "Dowiedz się więcej w Explorerze"),
        "txFetchingRemoteData": MessageLookupByLibrary.simpleMessage(
            "Pobieranie danych z serwera. Proszę czekać..."),
        "txHash": m8,
        "txHintMemo": MessageLookupByLibrary.simpleMessage("Memo"),
        "txHintSendFrom": MessageLookupByLibrary.simpleMessage("Wyślij od"),
        "txHintSendTo": MessageLookupByLibrary.simpleMessage("Wyślij do"),
        "txIsBeingBroadcast": MessageLookupByLibrary.simpleMessage(
            "Twoja transakcja jest przetwarzana"),
        "txListAmount": MessageLookupByLibrary.simpleMessage("Kwota"),
        "txListAmountFeesOnly":
            MessageLookupByLibrary.simpleMessage("Tylko opłaty"),
        "txListAmountPlusFees":
            MessageLookupByLibrary.simpleMessage("+ opłata"),
        "txListAmountPlusMore": m9,
        "txListDate": MessageLookupByLibrary.simpleMessage("Data"),
        "txListDetails": MessageLookupByLibrary.simpleMessage("Szczegóły"),
        "txListHash": MessageLookupByLibrary.simpleMessage("Hash transakcji"),
        "txListStatus": MessageLookupByLibrary.simpleMessage("Status"),
        "txListStatusConfirmed":
            MessageLookupByLibrary.simpleMessage("Potwierdzono"),
        "txListStatusFailed": MessageLookupByLibrary.simpleMessage("Odrzucono"),
        "txListStatusPending":
            MessageLookupByLibrary.simpleMessage("W trakcie"),
        "txMsgCancelIdentityRecordsVerifyRequest":
            MessageLookupByLibrary.simpleMessage(
                "Anuluj wniosek o weryfikację"),
        "txMsgDeleteIdentityRecords":
            MessageLookupByLibrary.simpleMessage("Usuń rekordy tożsamości"),
        "txMsgHandleIdentityRecordsVerifyRequest":
            MessageLookupByLibrary.simpleMessage(
                "Obsłuż wniosek o weryfikację"),
        "txMsgMulti": MessageLookupByLibrary.simpleMessage("Multi transakcja"),
        "txMsgRegisterIdentityRecords": MessageLookupByLibrary.simpleMessage(
            "Zarejestruj rekordy tożsamości"),
        "txMsgRequestIdentityRecordsVerify":
            MessageLookupByLibrary.simpleMessage("Wnioskuj o weryfikację"),
        "txMsgSendReceiveTokens":
            MessageLookupByLibrary.simpleMessage("Odbierz"),
        "txMsgSendSendTokens": MessageLookupByLibrary.simpleMessage("Wyślij"),
        "txMsgUndefined":
            MessageLookupByLibrary.simpleMessage("Nieznany rodzaj transakcji"),
        "txNoticeFee": m10,
        "txPleaseSelectToken":
            MessageLookupByLibrary.simpleMessage("Proszę wybrać token"),
        "txPreviewUnavailable": m11,
        "txRecipientWillGet":
            MessageLookupByLibrary.simpleMessage("Odbiorca otrzyma"),
        "txSearchTokens":
            MessageLookupByLibrary.simpleMessage("Szukaj tokenów"),
        "txSendTokens": MessageLookupByLibrary.simpleMessage("Wyślij tokeny"),
        "txSigning":
            MessageLookupByLibrary.simpleMessage("Podpisywanie transakcji"),
        "txToastHashCopied": MessageLookupByLibrary.simpleMessage(
            "Hash transakcji skopiowany do schowka"),
        "txToken": MessageLookupByLibrary.simpleMessage("Token"),
        "txTotalAmount": MessageLookupByLibrary.simpleMessage("Łączna kwota"),
        "txTryAgain": MessageLookupByLibrary.simpleMessage("Spróbuj ponownie"),
        "txWarningDoNotCloseWindow":
            MessageLookupByLibrary.simpleMessage("Nie zamykaj tego okna"),
        "validatorActive": MessageLookupByLibrary.simpleMessage("Aktywny"),
        "validatorInactive": MessageLookupByLibrary.simpleMessage("Nieaktywny"),
        "validatorJailed": MessageLookupByLibrary.simpleMessage("Zablokowany"),
        "validatorPaused": MessageLookupByLibrary.simpleMessage("Zatrzymany"),
        "validatorWaiting": MessageLookupByLibrary.simpleMessage("Oczekujący"),
        "validators": MessageLookupByLibrary.simpleMessage("Walidatorzy"),
        "validatorsActive": MessageLookupByLibrary.simpleMessage("Aktywni"),
        "validatorsButtonFilter": m12,
        "validatorsDropdownAll":
            MessageLookupByLibrary.simpleMessage("Wszyscy"),
        "validatorsHintSearch":
            MessageLookupByLibrary.simpleMessage("Szukaj walidatorów"),
        "validatorsInactive":
            MessageLookupByLibrary.simpleMessage("Nieaktywni"),
        "validatorsJailed": MessageLookupByLibrary.simpleMessage("Zablokowani"),
        "validatorsList":
            MessageLookupByLibrary.simpleMessage("Lista Walidatorów"),
        "validatorsPaused": MessageLookupByLibrary.simpleMessage("Zatrzymani"),
        "validatorsTableMoniker":
            MessageLookupByLibrary.simpleMessage("Moniker"),
        "validatorsTableStatus": MessageLookupByLibrary.simpleMessage("Status"),
        "validatorsTableStreak":
            MessageLookupByLibrary.simpleMessage("Bezawaryjna seria"),
        "validatorsTableTop": MessageLookupByLibrary.simpleMessage("Pozycja"),
        "validatorsTableUptime":
            MessageLookupByLibrary.simpleMessage("Czas działania"),
        "validatorsTotal": MessageLookupByLibrary.simpleMessage("Wszystkich"),
        "validatorsWaiting": MessageLookupByLibrary.simpleMessage("Oczekujący")
      };
}
