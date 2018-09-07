import 'package:address_book/middleware_manager.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

main() {
  group('MiddlewareManager', () {
    MockAddressController mockAddressController;
    MiddlewareManager sut;

    setUp(() {
      mockAddressController = MockAddressController();
      sut = MiddlewareManager(mockAddressController);
    });

    tearDown(() {
      mockAddressController = null;
      sut = null;
    });

    final middlewaresCount = 3;
    test('middleware to have $middlewaresCount items in array', () {
      expect(sut.middlewares().length, middlewaresCount);
    });
  });
}
