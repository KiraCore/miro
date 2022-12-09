import 'package:flutter_test/flutter_test.dart';

import 'mock_data/mock_browser_url_controller.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/controllers/browser/browser_url_controller_test.dart --platform chrome --null-assertions
// ignore_for_file: cascade_invocations
void main() {
  group('Tests of queryParameters getter', () {
    test('Should return empty map for Url without query parameters', () {
      // Arrange
      MockBrowserUrlController actualMockBrowserUrlController = MockBrowserUrlController(mockedUri: Uri.parse('http://miro.kira.network'));

      // Assert
      Map<String, dynamic> expectedQueryParameters = <String, dynamic>{};
      expect(actualMockBrowserUrlController.extractQueryParameters(), expectedQueryParameters);
    });

    test('Should return empty map for Url with path parameters and without query parameters', () {
      // Arrange
      MockBrowserUrlController actualMockBrowserUrlController =
          MockBrowserUrlController(mockedUri: Uri.parse('http://miro.kira.network/home/account'));

      // Assert
      Map<String, dynamic> expectedQueryParameters = <String, dynamic>{};

      expect(actualMockBrowserUrlController.extractQueryParameters(), expectedQueryParameters);
    });

    test('Should return map containing query parameters for Url without path parameters', () {
      // Arrange
      MockBrowserUrlController actualMockBrowserUrlController =
          MockBrowserUrlController(mockedUri: Uri.parse('http://miro.kira.network?rpc=http://unhealthy.kira.network'));

      // Assert
      Map<String, dynamic> expectedQueryParameters = <String, dynamic>{
        'rpc': 'http://unhealthy.kira.network',
      };

      expect(actualMockBrowserUrlController.extractQueryParameters(), expectedQueryParameters);
    });

    test('Should return map with one query parameter for Url with path parameters and one query parameter', () {
      // Arrange
      MockBrowserUrlController actualMockBrowserUrlController =
          MockBrowserUrlController(mockedUri: Uri.parse('http://miro.kira.network/home/account?rpc=http://unhealthy.kira.network'));

      // Assert
      Map<String, dynamic> expectedQueryParameters = <String, dynamic>{
        'rpc': 'http://unhealthy.kira.network',
      };

      expect(actualMockBrowserUrlController.extractQueryParameters(), expectedQueryParameters);
    });

    test('Should return map with three query parameters for Url with path parameters and multiple query parameters', () {
      // Arrange
      MockBrowserUrlController actualMockBrowserUrlController =
          MockBrowserUrlController(mockedUri: Uri.parse('http://miro.kira.network/home/account?rpc=http://unhealthy.kira.network&type=1&amount=100'));

      // Assert
      Map<String, dynamic> expectedQueryParameters = <String, dynamic>{
        'rpc': 'http://unhealthy.kira.network',
        'type': '1',
        'amount': '100',
      };

      expect(actualMockBrowserUrlController.extractQueryParameters(), expectedQueryParameters);
    });
  });

  group('Tests of queryParameters setter', () {
    test('Should return url with added queryParameters for Url without previously existed query parameters', () {
      // Arrange
      MockBrowserUrlController actualMockBrowserUrlController = MockBrowserUrlController(mockedUri: Uri.parse('http://miro.kira.network'));

      // Act
      actualMockBrowserUrlController.replaceQueryParameters(<String, dynamic>{
        'rpc': 'http://unhealthy.kira.network',
      });

      // Assert
      Uri expectedUri = Uri.parse('http://miro.kira.network?rpc=http%3A%2F%2Funhealthy.kira.network');

      expect(actualMockBrowserUrlController.uri, expectedUri);
    });

    test('Should return url with added queryParameters for Url with path parameters and without previously existed query parameters', () {
      // Arrange
      MockBrowserUrlController actualMockBrowserUrlController =
          MockBrowserUrlController(mockedUri: Uri.parse('http://miro.kira.network/home/account'));

      // Act
      actualMockBrowserUrlController.replaceQueryParameters( <String, dynamic>{
        'rpc': 'http://unhealthy.kira.network',
      });

      // Assert
      Uri expectedUri = Uri.parse('http://miro.kira.network/home/account?rpc=http%3A%2F%2Funhealthy.kira.network');

      expect(actualMockBrowserUrlController.uri, expectedUri);
    });

    test('Should return url with overwritten queryParameters for Url with previously existed query parameters', () {
      // Arrange
      MockBrowserUrlController actualMockBrowserUrlController =
          MockBrowserUrlController(mockedUri: Uri.parse('http://miro.kira.network?rpc=http://offline.kira.network'));

      // Act
      actualMockBrowserUrlController.replaceQueryParameters(<String, dynamic>{
        'rpc': 'http://unhealthy.kira.network',
      });

      // Assert
      Uri expectedUri = Uri.parse('http://miro.kira.network?rpc=http%3A%2F%2Funhealthy.kira.network');

      expect(actualMockBrowserUrlController.uri, expectedUri);
    });

    test('Should return url with overwritten queryParameters for Url with path parameters and previously existed query parameters', () {
      // Arrange
      MockBrowserUrlController actualMockBrowserUrlController =
          MockBrowserUrlController(mockedUri: Uri.parse('http://miro.kira.network/home/account?rpc=http://offline.kira.network'));

      // Act
      actualMockBrowserUrlController.replaceQueryParameters(<String, dynamic>{
        'rpc': 'http://unhealthy.kira.network',
      });

      // Assert
      Uri expectedUri = Uri.parse('http://miro.kira.network/home/account?rpc=http%3A%2F%2Funhealthy.kira.network');

      expect(actualMockBrowserUrlController.uri, expectedUri);
    });
  });
}
