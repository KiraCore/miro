import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api/deposits/response/deposits_transactions.dart';
import 'package:miro/infra/dto/api/deposits/response/deposits_tx.dart';
import 'package:miro/infra/dto/api/transaction_object.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_transactions.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_tx.dart';
import 'package:miro/shared/utils/pages/transactions_comparator.dart';

void main() {
  // Actual values for tests
  Set<TransactionObject> actualAllTransactions = <TransactionObject>{
    WithdrawsTransactions(
      hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
      time: 1648643551,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
      ],
    ),
    WithdrawsTransactions(
      hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
      time: 1648643515,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102),
      ],
    ),
    WithdrawsTransactions(
      hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
      time: 1648643463,
      txs: <WithdrawsTx>[
        WithdrawsTx(address: 'kira377lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 103),
      ],
    ),
    DepositsTransactions(
      hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
      time: 1648130242,
      txs: <DepositsTx>[
        DepositsTx(address: 'kira477lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 104),
      ],
    ),
    DepositsTransactions(
      hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
      time: 1648069106,
      txs: <DepositsTx>[
        DepositsTx(address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200),
      ],
    ),
  };

  group('Tests of TransactionsComparator.date', () {
    test('Should return 0 (Date equal)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.date).comparator(
              WithdrawsTransactions(
                hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
              WithdrawsTransactions(
                hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
            ),
        0,
      );
    });

    test('Should return 1 (First date after second)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.date).comparator(
              WithdrawsTransactions(
                hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
              WithdrawsTransactions(
                hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
                time: 1648643515,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102),
                ],
              ),
            ),
        1,
      );
    });

    test('Should return -1 (First date before second)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.date).comparator(
              WithdrawsTransactions(
                hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
                time: 1648643515,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102),
                ],
              ),
              WithdrawsTransactions(
                hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
            ),
        -1,
      );
    });

    test('Should return list sorted by date', () {
      List<TransactionObject> actualTransactions = actualAllTransactions.toList()
        ..sort(TransactionsComparator().getSortOption(TransactionSortOption.date).comparator);
      expect(
        actualTransactions,
        <TransactionObject>[
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1648069106,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200),
              ]),
          DepositsTransactions(
              hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
              time: 1648130242,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira477lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 104),
              ]),
          WithdrawsTransactions(
              hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
              time: 1648643463,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira377lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 103),
              ]),
          WithdrawsTransactions(
              hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
              time: 1648643515,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102),
              ]),
          WithdrawsTransactions(
              hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
              time: 1648643551,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
              ])
        ],
      );
    });
  });

  group('Tests of TransactionsComparator.details', () {
    test('Should return 0 (Details strings equal)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.details).comparator(
              WithdrawsTransactions(
                hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
              WithdrawsTransactions(
                hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
            ),
        0,
      );
    });

    test('Should return 1 (First details string greater than second)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.details).comparator(
              WithdrawsTransactions(
                hash: '0xZ7CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
              WithdrawsTransactions(
                hash: '0xA5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
                time: 1648643515,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102),
                ],
              ),
            ),
        1,
      );
    });

    test('Should return -1 (First details string less than second)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.details).comparator(
              WithdrawsTransactions(
                hash: '0xA5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
                time: 1648643515,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102),
                ],
              ),
              WithdrawsTransactions(
                hash: '0xZ7CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
            ),
        -1,
      );
    });

    test('Should return list sorted by details', () {
      List<TransactionObject> actualTransactions = actualAllTransactions.toList()
        ..sort(TransactionsComparator().getSortOption(TransactionSortOption.details).comparator);
      expect(
        actualTransactions,
        <TransactionObject>[
          WithdrawsTransactions(
              hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
              time: 1648643551,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101)
              ]),
          WithdrawsTransactions(
              hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
              time: 1648643515,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102)
              ]),
          WithdrawsTransactions(
              hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
              time: 1648643463,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira377lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 103)
              ]),
          DepositsTransactions(
              hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
              time: 1648130242,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira477lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 104)
              ]),
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1648069106,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ])
        ],
      );
    });
  });

  group('Tests of TransactionsComparator.hash', () {
    test('Should return 0 (hash strings equal)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.hash).comparator(
              WithdrawsTransactions(
                hash: '0xAAAAA',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
              WithdrawsTransactions(
                hash: '0xAAAAA',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
            ),
        0,
      );
    });

    test('Should return 1 (First hash string greater than second)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.hash).comparator(
              WithdrawsTransactions(
                hash: '0xZZZZZ',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
              WithdrawsTransactions(
                hash: '0xAAAAA',
                time: 1648643515,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102),
                ],
              ),
            ),
        1,
      );
    });

    test('Should return -1 (First hash string less than second)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.hash).comparator(
              WithdrawsTransactions(
                hash: '0xAAAAA',
                time: 1648643515,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102),
                ],
              ),
              WithdrawsTransactions(
                hash: '0xZZZZZ',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
            ),
        -1,
      );
    });

    test('Should return list sorted by hash', () {
      List<TransactionObject> actualTransactions = actualAllTransactions.toList()
        ..sort(TransactionsComparator().getSortOption(TransactionSortOption.hash).comparator);
      expect(
        actualTransactions,
        <TransactionObject>[
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1648069106,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ]),
          WithdrawsTransactions(
              hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
              time: 1648643551,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101)
              ]),
          DepositsTransactions(
              hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
              time: 1648130242,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira477lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 104)
              ]),
          WithdrawsTransactions(
              hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
              time: 1648643463,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira377lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 103)
              ]),
          WithdrawsTransactions(
              hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
              time: 1648643515,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102)
              ])
        ],
      );
    });
  });

  group('Tests of TransactionsComparator.amount', () {
    test('Should return 0 (amounts equal)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.amount).comparator(
              WithdrawsTransactions(
                hash: '0xAAAAA',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
              WithdrawsTransactions(
                hash: '0xAAAAA',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
            ),
        0,
      );
    });

    test('Should return 1 (First amount greater than second)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.amount).comparator(
              WithdrawsTransactions(
                hash: '0xZZZZZ',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102),
                ],
              ),
              WithdrawsTransactions(
                hash: '0xAAAAA',
                time: 1648643515,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
            ),
        1,
      );
    });

    test('Should return -1 (First amount less than second)', () {
      expect(
        TransactionsComparator().getSortOption(TransactionSortOption.amount).comparator(
              WithdrawsTransactions(
                hash: '0xAAAAA',
                time: 1648643515,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
                ],
              ),
              WithdrawsTransactions(
                hash: '0xZZZZZ',
                time: 1648643551,
                txs: <WithdrawsTx>[
                  WithdrawsTx(
                      address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102),
                ],
              ),
            ),
        -1,
      );
    });

    test('Should return list sorted by amount', () {
      List<TransactionObject> actualTransactions = actualAllTransactions.toList()
        ..sort(TransactionsComparator().getSortOption(TransactionSortOption.amount).comparator);
      expect(
        actualTransactions,
        <TransactionObject>[
          WithdrawsTransactions(
              hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
              time: 1648643551,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101)
              ]),
          WithdrawsTransactions(
              hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
              time: 1648643515,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102)
              ]),
          WithdrawsTransactions(
              hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
              time: 1648643463,
              txs: <WithdrawsTx>[
                WithdrawsTx(
                    address: 'kira377lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 103)
              ]),
          DepositsTransactions(
              hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
              time: 1648130242,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira477lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 104)
              ]),
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1648069106,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ]),
        ],
      );
    });
  });

  group('Tests of TransactionsComparator.filterByDate', () {
    test('Should return true if transaction date is between provided dates', () {
      expect(
        TransactionsComparator.filterByDate(
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1649239906,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ]),
          DateTime(2022, 4, 4),
          DateTime(2022, 4, 10),
        ),
        true,
      );
    });

    test('Should return true if transaction date is equal today date', () {
      expect(
        TransactionsComparator.filterByDate(
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1649239906,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ]),
          DateTime(2022, 4, 6),
          DateTime(2022, 4, 6),
        ),
        true,
      );
    });

    test('Should return false if transaction date is not between provided dates', () {
      expect(
        TransactionsComparator.filterByDate(
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1649239906,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ]),
          DateTime(2022, 4, 4),
          DateTime(2022, 4, 5),
        ),
        false,
      );
    });

    test('Should return list filtered by date', () {
      List<TransactionObject> actualTransactions = actualAllTransactions
          .where((TransactionObject item) =>
              TransactionsComparator.filterByDate(item, DateTime(2022, 3, 23), DateTime(2022, 3, 23)))
          .toList();
      expect(
        actualTransactions,
        <TransactionObject>[
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1648069106,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ])
        ],
      );
    });
  });

  group('Tests of TransactionsComparator.filterByDate', () {
    test('Should return true if hash contains provided search pattern', () {
      expect(
        TransactionsComparator.filterSearch(
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1649239906,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ]),
          '0x11A',
        ),
        true,
      );
    });

    test('Should return true if denom contains provided search pattern', () {
      expect(
        TransactionsComparator.filterSearch(
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1649239906,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ]),
          'kex',
        ),
        true,
      );
    });

    test('Should return true if amount contains provided search pattern', () {
      expect(
        TransactionsComparator.filterSearch(
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1649239906,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ]),
          '200',
        ),
        true,
      );
    });

    test('Should return true if address contains provided search pattern', () {
      expect(
        TransactionsComparator.filterSearch(
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1649239906,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ]),
          '577lwm',
        ),
        true,
      );
    });

    test('Should return list filtered by date value', () {
      List<TransactionObject> actualTransactions = actualAllTransactions
          .where((TransactionObject item) => TransactionsComparator.filterSearch(item, '200'))
          .toList();
      expect(
        actualTransactions,
        <TransactionObject>[
          DepositsTransactions(
              hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
              time: 1648069106,
              txs: <DepositsTx>[
                DepositsTx(
                    address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200)
              ])
        ],
      );
    });
  });

  group('Tests of TransactionsComparator._filterByWithdraws', () {
    test('Should return withdraws list only', () {
      List<TransactionObject> actualTransactions = actualAllTransactions
          .where(TransactionsComparator().getFilterOption(TransactionFilterOption.withdraws).comparator)
          .toList();
      expect(
        actualTransactions,
        <TransactionObject>[
          WithdrawsTransactions(
            hash: '0x67CEDD00A4239E17C89773E9DFC06FC459FBC95FF32C9D1838F71FEF01AEA315',
            time: 1648643551,
            txs: <WithdrawsTx>[
              WithdrawsTx(
                  address: 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 101),
            ],
          ),
          WithdrawsTransactions(
            hash: '0xF5C03F8A6963778B0572CEE7D8CAE9C3A41709CA6366ECC27262915A1A007183',
            time: 1648643515,
            txs: <WithdrawsTx>[
              WithdrawsTx(
                  address: 'kira277lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 102),
            ],
          ),
          WithdrawsTransactions(
            hash: '0xE57A97B35BF970F277BEAD411B665B10B714A63C41AD93AE71808BA87F60A9F4',
            time: 1648643463,
            txs: <WithdrawsTx>[
              WithdrawsTx(
                  address: 'kira377lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 103),
            ],
          ),
        ],
      );
    });
  });

  group('Tests of TransactionsComparator._filterByDeposits', () {
    test('Should return deposits list only', () {
      List<TransactionObject> actualTransactions = actualAllTransactions
          .where(TransactionsComparator().getFilterOption(TransactionFilterOption.deposits).comparator)
          .toList();
      expect(
        actualTransactions,
        <TransactionObject>[
          DepositsTransactions(
            hash: '0x709928F5D87F08528B5384993928A10F899C2638860FB09BA09F934E0B38E4E5',
            time: 1648130242,
            txs: <DepositsTx>[
              DepositsTx(
                  address: 'kira477lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 104),
            ],
          ),
          DepositsTransactions(
            hash: '0x11A87E72956699ADEEC4EC254ED1752BE91F703DE3D97CFB79C2B82F1552B1AA',
            time: 1648069106,
            txs: <DepositsTx>[
              DepositsTx(
                  address: 'kira577lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl', type: 'send', denom: 'ukex', amount: 200),
            ],
          ),
        ],
      );
    });
  });
}
