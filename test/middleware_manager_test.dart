import 'package:address_book/redux/middleware_manager.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

main() {
  group('MiddlewareManager', () {
    MockAddressController mockAddressController;
    MiddlewareManager sut;

    setUp(() {
      mockAddressController = MockAddressController();
      sut = MiddlewareManager(addressController: mockAddressController);
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
