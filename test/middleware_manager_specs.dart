import 'package:flutter_test/flutter_test.dart';
import 'package:address_book/middleware_manager.dart';
import 'mocks.dart';


main() {
  group('MiddlewareManager', () {
    MockAddressController addressController;
    MiddlewareManager sut;

    setUp(() {
      addressController = MockAddressController();
      sut = MiddlewareManager(addressController);
    });

    tearDown(() {
      addressController = null;
      sut = null;
    });

    test('middleware to have 2 items in array', () {
      expect(sut.middlewares().length, 2);
    });
  });
}
