import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_sort_options.dart';
import 'package:miro/shared/models/validators/validator_model.dart';

void main() {
  List<ValidatorModel> validatorsList = <ValidatorModel>[
    ValidatorModel(top: 1, address: '0x10', moniker: 'apple', validatorStatus: ValidatorStatus.active),
    ValidatorModel(top: 2, address: '0x9', moniker: 'banana', validatorStatus: ValidatorStatus.inactive),
    ValidatorModel(top: 3, address: '0x8', moniker: 'coconut', validatorStatus: ValidatorStatus.jailed),
    ValidatorModel(top: 4, address: '0x7', moniker: 'dasheen', validatorStatus: ValidatorStatus.paused),
    ValidatorModel(top: 5, address: '0x6', moniker: 'eggplant', validatorStatus: ValidatorStatus.waiting),
    ValidatorModel(top: 6, address: '0x5', moniker: 'fig', validatorStatus: ValidatorStatus.active),
    ValidatorModel(top: 7, address: '0x4', moniker: 'grape', validatorStatus: ValidatorStatus.inactive),
    ValidatorModel(top: 8, address: '0x3', moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed),
    ValidatorModel(top: 9, address: '0x2', moniker: 'ice', validatorStatus: ValidatorStatus.paused),
    ValidatorModel(top: 10, address: '0x1', moniker: 'jalapeno', validatorStatus: ValidatorStatus.waiting),
  ];

  group('Tests of sortByTop', () {
    test('Should return validatorsList sorted by "top" ascending', () {
      expect(
        ValidatorsSortOptions.sortByTop.sort(validatorsList),
        <ValidatorModel>[
          ValidatorModel(top: 1, address: '0x10', moniker: 'apple', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 2, address: '0x9', moniker: 'banana', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 3, address: '0x8', moniker: 'coconut', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 4, address: '0x7', moniker: 'dasheen', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 5, address: '0x6', moniker: 'eggplant', validatorStatus: ValidatorStatus.waiting),
          ValidatorModel(top: 6, address: '0x5', moniker: 'fig', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 7, address: '0x4', moniker: 'grape', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 8, address: '0x3', moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 9, address: '0x2', moniker: 'ice', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 10, address: '0x1', moniker: 'jalapeno', validatorStatus: ValidatorStatus.waiting),
        ],
      );
    });

    test('Should return validatorsList sorted by "top" descending', () {
      expect(
        ValidatorsSortOptions.sortByTop.reversed().sort(validatorsList),
        <ValidatorModel>[
          ValidatorModel(top: 10, address: '0x1', moniker: 'jalapeno', validatorStatus: ValidatorStatus.waiting),
          ValidatorModel(top: 9, address: '0x2', moniker: 'ice', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 8, address: '0x3', moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 7, address: '0x4', moniker: 'grape', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 6, address: '0x5', moniker: 'fig', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 5, address: '0x6', moniker: 'eggplant', validatorStatus: ValidatorStatus.waiting),
          ValidatorModel(top: 4, address: '0x7', moniker: 'dasheen', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 3, address: '0x8', moniker: 'coconut', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 2, address: '0x9', moniker: 'banana', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 1, address: '0x10', moniker: 'apple', validatorStatus: ValidatorStatus.active),
        ],
      );
    });
  });

  group('Tests of sortByMoniker', () {
    test('Should return validatorsList sorted by "moniker" ascending', () {
      expect(
        ValidatorsSortOptions.sortByMoniker.sort(validatorsList),
        <ValidatorModel>[
          ValidatorModel(top: 1, address: '0x10', moniker: 'apple', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 2, address: '0x9', moniker: 'banana', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 3, address: '0x8', moniker: 'coconut', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 4, address: '0x7', moniker: 'dasheen', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 5, address: '0x6', moniker: 'eggplant', validatorStatus: ValidatorStatus.waiting),
          ValidatorModel(top: 6, address: '0x5', moniker: 'fig', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 7, address: '0x4', moniker: 'grape', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 8, address: '0x3', moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 9, address: '0x2', moniker: 'ice', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 10, address: '0x1', moniker: 'jalapeno', validatorStatus: ValidatorStatus.waiting),
        ],
      );
    });

    test('Should return validatorsList sorted by "moniker" descending', () {
      expect(
        ValidatorsSortOptions.sortByMoniker.reversed().sort(validatorsList),
        <ValidatorModel>[
          ValidatorModel(top: 1, address: '0x10', moniker: 'apple', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 2, address: '0x9', moniker: 'banana', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 3, address: '0x8', moniker: 'coconut', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 4, address: '0x7', moniker: 'dasheen', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 5, address: '0x6', moniker: 'eggplant', validatorStatus: ValidatorStatus.waiting),
          ValidatorModel(top: 6, address: '0x5', moniker: 'fig', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 7, address: '0x4', moniker: 'grape', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 8, address: '0x3', moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 9, address: '0x2', moniker: 'ice', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 10, address: '0x1', moniker: 'jalapeno', validatorStatus: ValidatorStatus.waiting),
        ],
      );
    });
  });

  group('Tests of sortByStatus', () {
    test('Should return validatorsList sorted by "status" ascending', () {
      expect(
        ValidatorsSortOptions.sortByStatus.sort(validatorsList),
        <ValidatorModel>[
          ValidatorModel(top: 10, address: '0x1', moniker: 'jalapeno', validatorStatus: ValidatorStatus.waiting),
          ValidatorModel(top: 9, address: '0x2', moniker: 'ice', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 8, address: '0x3', moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 7, address: '0x4', moniker: 'grape', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 6, address: '0x5', moniker: 'fig', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 5, address: '0x6', moniker: 'eggplant', validatorStatus: ValidatorStatus.waiting),
          ValidatorModel(top: 4, address: '0x7', moniker: 'dasheen', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 3, address: '0x8', moniker: 'coconut', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 2, address: '0x9', moniker: 'banana', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 1, address: '0x10', moniker: 'apple', validatorStatus: ValidatorStatus.active),
        ],
      );
    });

    test('Should return validatorsList sorted by "status" descending', () {
      expect(
        ValidatorsSortOptions.sortByStatus.reversed().sort(validatorsList),
        <ValidatorModel>[
          ValidatorModel(top: 5, address: '0x6', moniker: 'eggplant', validatorStatus: ValidatorStatus.waiting),
          ValidatorModel(top: 10, address: '0x1', moniker: 'jalapeno', validatorStatus: ValidatorStatus.waiting),
          ValidatorModel(top: 4, address: '0x7', moniker: 'dasheen', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 9, address: '0x2', moniker: 'ice', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 3, address: '0x8', moniker: 'coconut', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 8, address: '0x3', moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 2, address: '0x9', moniker: 'banana', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 7, address: '0x4', moniker: 'grape', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 1, address: '0x10', moniker: 'apple', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 6, address: '0x5', moniker: 'fig', validatorStatus: ValidatorStatus.active),
        ],
      );
    });
  });
}
