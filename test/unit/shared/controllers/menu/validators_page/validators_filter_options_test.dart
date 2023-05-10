import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/controllers/menu/validators_page/validators_filter_options.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/validators/validator_status.dart';

void main() {
  List<ValidatorModel> validatorsList = <ValidatorModel>[
    ValidatorModel(top: 1, address: '0x8', moniker: 'apple5', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10'),
    ValidatorModel(top: 2, address: '0x7', moniker: 'banana4', validatorStatus: ValidatorStatus.inactive, uptime: 2, streak: '20'),
    ValidatorModel(top: 3, address: '0x6', moniker: 'coconut3', validatorStatus: ValidatorStatus.jailed, uptime: 3, streak: '30'),
    ValidatorModel(top: 4, address: '0x5', moniker: 'dasheen2', validatorStatus: ValidatorStatus.paused, uptime: 4, streak: '40'),
    ValidatorModel(top: 5, address: '0x4', moniker: 'fig1', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50'),
    ValidatorModel(top: 6, address: '0x3', moniker: 'grape2', validatorStatus: ValidatorStatus.inactive, uptime: 6, streak: '60'),
    ValidatorModel(top: 7, address: '0x2', moniker: 'huckleberry3', validatorStatus: ValidatorStatus.jailed, uptime: 7, streak: '70'),
    ValidatorModel(top: 8, address: '0x1', moniker: 'ice4', validatorStatus: ValidatorStatus.paused, uptime: 8, streak: '80'),
  ];

  group('Tests of filterByActiveValidators', () {
    test('Should return only active validators', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.filterByActiveValidators.filterComparator;

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 1, address: '0x8', moniker: 'apple', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10'),
        ValidatorModel(top: 5, address: '0x4', moniker: 'fig', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50'),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of filterByInactiveValidators', () {
    test('Should return only inactive validators', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.filterByInactiveValidators.filterComparator;

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 2, address: '0x7', moniker: 'banana', validatorStatus: ValidatorStatus.inactive, uptime: 2, streak: '20'),
        ValidatorModel(top: 6, address: '0x3', moniker: 'grape', validatorStatus: ValidatorStatus.inactive, uptime: 6, streak: '60'),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of filterByJailedValidators', () {
    test('Should return only jailed validators', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.filterByJailedValidators.filterComparator;

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 3, address: '0x6', moniker: 'coconut', validatorStatus: ValidatorStatus.jailed, uptime: 3, streak: '30'),
        ValidatorModel(top: 7, address: '0x2', moniker: 'huckleberry', validatorStatus: ValidatorStatus.jailed, uptime: 7, streak: '70'),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of filterByPausedValidators', () {
    test('Should return only paused validators', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.filterByPausedValidators.filterComparator;

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 4, address: '0x5', moniker: 'dasheen', validatorStatus: ValidatorStatus.paused, uptime: 4, streak: '40'),
        ValidatorModel(top: 8, address: '0x1', moniker: 'ice', validatorStatus: ValidatorStatus.paused, uptime: 8, streak: '80'),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });

  group('Tests of search method', () {
    test('Should return only validators matching "apple"', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.search('apple');

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 1, address: '0x8', moniker: 'apple', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10'),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });

    test('Should return only validators matching "1"', () {
      // Arrange
      FilterComparator<ValidatorModel> filterComparator = ValidatorsFilterOptions.search('1');

      // Act
      List<ValidatorModel> actualValidatorsList = validatorsList.where(filterComparator).toList();

      // Assert
      List<ValidatorModel> expectedValidatorsList = <ValidatorModel>[
        ValidatorModel(top: 1, address: '0x8', moniker: 'apple5', validatorStatus: ValidatorStatus.active, uptime: 1, streak: '10'),
        ValidatorModel(top: 5, address: '0x4', moniker: 'fig1', validatorStatus: ValidatorStatus.active, uptime: 5, streak: '50'),
      ];

      expect(actualValidatorsList, expectedValidatorsList);
    });
  });
}
