import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_filter_options.dart';
import 'package:miro/shared/models/validators/validator_model.dart';

void main() {
  List<ValidatorModel> validatorsList = <ValidatorModel>[
    ValidatorModel(top: 1, address: '0x10', moniker: 'apple5', validatorStatus: ValidatorStatus.active),
    ValidatorModel(top: 2, address: '0x9', moniker: 'banana4', validatorStatus: ValidatorStatus.inactive),
    ValidatorModel(top: 3, address: '0x8', moniker: 'coconut3', validatorStatus: ValidatorStatus.jailed),
    ValidatorModel(top: 4, address: '0x7', moniker: 'dasheen2', validatorStatus: ValidatorStatus.paused),
    ValidatorModel(top: 5, address: '0x6', moniker: 'eggplant1', validatorStatus: ValidatorStatus.waiting),
    ValidatorModel(top: 6, address: '0x5', moniker: 'fig1', validatorStatus: ValidatorStatus.active),
    ValidatorModel(top: 7, address: '0x4', moniker: 'grape2', validatorStatus: ValidatorStatus.inactive),
    ValidatorModel(top: 8, address: '0x3', moniker: 'huckleberry3', validatorStatus: ValidatorStatus.jailed),
    ValidatorModel(top: 9, address: '0x2', moniker: 'ice4', validatorStatus: ValidatorStatus.paused),
    ValidatorModel(top: 10, address: '0x1', moniker: 'jalapeno5', validatorStatus: ValidatorStatus.waiting),
  ];

  group('Tests of filterByActiveValidators', () {
    test('Should return only active validators', () {
      expect(
        validatorsList.where(ValidatorsFilterOptions.filterByActiveValidators.comparator).toList(),
        <ValidatorModel>[
          ValidatorModel(top: 1, address: '0x10', moniker: 'apple', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 6, address: '0x5', moniker: 'fig', validatorStatus: ValidatorStatus.active),
        ],
      );
    });
  });

  group('Tests of filterByInactiveValidators', () {
    test('Should return only inactive validators', () {
      expect(
        validatorsList.where(ValidatorsFilterOptions.filterByInactiveValidators.comparator).toList(),
        <ValidatorModel>[
          ValidatorModel(top: 2, address: '0x9', moniker: 'banana', validatorStatus: ValidatorStatus.inactive),
          ValidatorModel(top: 7, address: '0x4', moniker: 'grape', validatorStatus: ValidatorStatus.inactive),
        ],
      );
    });
  });

  group('Tests of filterByJailedValidators', () {
    test('Should return only jailed validators', () {
      expect(
        validatorsList.where(ValidatorsFilterOptions.filterByJailedValidators.comparator).toList(),
        <ValidatorModel>[
          ValidatorModel(top: 3, address: '0x8', moniker: 'coconut', validatorStatus: ValidatorStatus.jailed),
          ValidatorModel(top: 8, address: '0x3', moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed),
        ],
      );
    });
  });

  group('Tests of filterByPausedValidators', () {
    test('Should return only paused validators', () {
      expect(
        validatorsList.where(ValidatorsFilterOptions.filterByPausedValidators.comparator).toList(),
        <ValidatorModel>[
          ValidatorModel(top: 4, address: '0x7', moniker: 'dasheen', validatorStatus: ValidatorStatus.paused),
          ValidatorModel(top: 9, address: '0x2', moniker: 'ice', validatorStatus: ValidatorStatus.paused),
        ],
      );
    });
  });

  group('Tests of filterByWaitingValidators', () {
    test('Should return only waiting validators', () {
      expect(
        validatorsList.where(ValidatorsFilterOptions.filterByWaitingValidators.comparator).toList(),
        <ValidatorModel>[
          ValidatorModel(top: 5, address: '0x6', moniker: 'eggplant', validatorStatus: ValidatorStatus.waiting),
          ValidatorModel(top: 10, address: '0x1', moniker: 'jalapeno', validatorStatus: ValidatorStatus.waiting),
        ],
      );
    });
  });

  group('Tests of search method', () {
    test('Should return only validators matching "apple"', () {
      expect(
        validatorsList.where(ValidatorsFilterOptions.search('apple')).toList(),
        <ValidatorModel>[
          ValidatorModel(top: 1, address: '0x10', moniker: 'apple', validatorStatus: ValidatorStatus.active),
        ],
      );
    });

    test('Should return only validators matching "1"', () {
      expect(
        validatorsList.where(ValidatorsFilterOptions.search('1')).toList(),
        <ValidatorModel>[
          ValidatorModel(top: 1, address: '0x10', moniker: 'apple5', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 5, address: '0x6', moniker: 'eggplant1', validatorStatus: ValidatorStatus.waiting),
          ValidatorModel(top: 6, address: '0x5', moniker: 'fig1', validatorStatus: ValidatorStatus.active),
          ValidatorModel(top: 10, address: '0x1', moniker: 'jalapeno5', validatorStatus: ValidatorStatus.waiting),
        ],
      );
    });
  });
}
