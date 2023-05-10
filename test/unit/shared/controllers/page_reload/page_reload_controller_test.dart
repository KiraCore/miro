import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/page_reload/page_reload_controller.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/controllers/page_reload/page_reload_controller_test.dart --platform chrome --null-assertions
void main() {
  group('Tests of PageReloadController process for PageReloadConditionType.differentNetwork', () {
    test('Should return values assigned to specified actions', () {
      // Arrange
      PageReloadController actualPageReloadController = PageReloadController();

      // Assert
      TestUtils.printInfo('Should return "0" as initial value of activeReloadId');
      expect(actualPageReloadController.activeReloadId, 0);

      // Assert
      TestUtils.printInfo('Should return "true" if reloadId is active');
      expect(actualPageReloadController.canReloadComplete(0), true);

      // Assert
      TestUtils.printInfo('Should return "true" if initial network is not set');
      expect(actualPageReloadController.hasNetworkChanged(TestUtils.networkHealthyModel), true);

      // Assert
      TestUtils.printInfo('Should return "false" as value of hasErrors');
      expect(actualPageReloadController.hasErrors, false);

      // ************************************************************************************************

      // Act
      actualPageReloadController.handleReloadCall(TestUtils.networkHealthyModel);

      // Assert
      TestUtils.printInfo('Should return "1" as value of activeReloadId, after first reload called');
      expect(actualPageReloadController.activeReloadId, 1);

      // Assert
      TestUtils.printInfo('Should return "false" if provided reloadId is inactive');
      expect(actualPageReloadController.canReloadComplete(0), false);

      // Assert
      TestUtils.printInfo('Should return "true" if provided reloadId is active');
      expect(actualPageReloadController.canReloadComplete(1), true);

      // Assert
      TestUtils.printInfo('Should return "true" if used network is other than provided network');
      expect(actualPageReloadController.hasNetworkChanged(TestUtils.networkUnhealthyModel), true);

      // Assert
      TestUtils.printInfo('Should return "false" if used network is equal provided network');
      expect(actualPageReloadController.hasNetworkChanged(TestUtils.networkHealthyModel), false);

      // Assert
      TestUtils.printInfo('Should return "false" if hasErrors is not set');
      expect(actualPageReloadController.hasErrors, false);

      // ************************************************************************************************

      // Act
      actualPageReloadController.handleReloadCall(TestUtils.networkUnhealthyModel);

      // Assert
      TestUtils.printInfo('Should return "2" as value of activeReloadId, after second reload called');
      expect(actualPageReloadController.activeReloadId, 2);

      // Assert
      TestUtils.printInfo('Should return "false" if provided reloadId is inactive');
      expect(actualPageReloadController.canReloadComplete(0), false);

      // Assert
      TestUtils.printInfo('Should return "false" if provided reloadId is inactive');
      expect(actualPageReloadController.canReloadComplete(1), false);

      // Assert
      TestUtils.printInfo('Should return "true" if provided reloadId is active');
      expect(actualPageReloadController.canReloadComplete(2), true);

      // Assert
      TestUtils.printInfo('Should return "false" if used network is equal provided network');
      expect(actualPageReloadController.hasNetworkChanged(TestUtils.networkUnhealthyModel), false);

      // Assert
      TestUtils.printInfo('Should return "true" if used network is other than provided network');
      expect(actualPageReloadController.hasNetworkChanged(TestUtils.networkHealthyModel), true);

      // Assert
      TestUtils.printInfo('Should set hasErrors to "false" after handleReloadCall');
      expect(actualPageReloadController.hasErrors, false);
    });
  });
}
