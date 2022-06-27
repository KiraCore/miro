import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/menu/validators_page/validators_sort_options.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/validators/validator_status.dart';

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
      // Act
      List<ValidatorModel> actualValidatorsList =
          ValidatorsSortOptions.sortByTop.sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
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

      expect(actualValidatorsList, expectedValidatorsList);
    });

    test('Should return validatorsList sorted by "top" descending', () {
      // Act
      List<ValidatorModel> actualValidatorsList =
          ValidatorsSortOptions.sortByTop.reversed().sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
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
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of sortByMoniker', () {
    test('Should return validatorsList sorted by "moniker" ascending', () {
      // Act
      List<ValidatorModel> actualValidatorsList =
          ValidatorsSortOptions.sortByMoniker.sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
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

      expect(actualValidatorsList, expectedValidatorsList);
    });

    test('Should return validatorsList sorted by "moniker" descending', () {
      // Act
      List<ValidatorModel> actualValidatorsList =
          ValidatorsSortOptions.sortByMoniker.reversed().sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
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
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of sortByStatus', () {
    test('Should return validatorsList sorted by "status" ascending', () {
      // Act
      List<ValidatorModel> actualValidatorsList =
          ValidatorsSortOptions.sortByStatus.sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 1, address: '0x10', moniker: 'apple', validatorStatus: ValidatorStatus.active),
        ValidatorModel(top: 6, address: '0x5', moniker: 'fig', validatorStatus: ValidatorStatus.active),
        ValidatorModel(top: 2, address: '0x9', moniker: 'banana', validatorStatus: ValidatorStatus.inactive),
        ValidatorModel(top: 7, address: '0x4', moniker: 'grape', validatorStatus: ValidatorStatus.inactive),
        ValidatorModel(top: 3, address: '0x8', moniker: 'coconut', validatorStatus: ValidatorStatus.jailed),
        ValidatorModel(top: 8, address: '0x3', moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed),
        ValidatorModel(top: 4, address: '0x7', moniker: 'dasheen', validatorStatus: ValidatorStatus.paused),
        ValidatorModel(top: 9, address: '0x2', moniker: 'ice', validatorStatus: ValidatorStatus.paused),
        ValidatorModel(top: 5, address: '0x6', moniker: 'eggplant', validatorStatus: ValidatorStatus.waiting),
        ValidatorModel(top: 10, address: '0x1', moniker: 'jalapeno', validatorStatus: ValidatorStatus.waiting),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });

    test('Should return validatorsList sorted by "status" descending', () {
      // Act
      List<ValidatorModel> actualValidatorsList =
          ValidatorsSortOptions.sortByStatus.reversed().sort(List<ValidatorModel>.from(validatorsList));

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
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
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });
}
