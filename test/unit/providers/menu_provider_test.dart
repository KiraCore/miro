import 'package:flutter_test/flutter_test.dart';
import 'package:miro/providers/menu_provider.dart';

void main() {
  MenuProvider menuProvider = MenuProvider();

  group('Tests of MenuProvider initial state', () {
    test('Should return default path', () {
      expect(
        menuProvider.currentPath,
        MenuProvider.defaultPath,
      );
    });
  });

  group('Tests of MenuProvider.updatePath() state', () {
    test('Should return ScaffoldMenuChangedRoute with provided route name', () {
      menuProvider.updatePath('accounts');
      expect(
        menuProvider.currentPath,
        'accounts',
      );
    });
  });
}
