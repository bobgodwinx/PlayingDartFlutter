import 'package:address_book/actions.dart';
import 'package:address_book/address_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

main() {
  group('AddressController', () {
    MockStore mockStore;
    AddressController sut;

    setUp(() {
      sut = AddressController(MockAddressProvider());
      mockStore = MockStore();
    });

    tearDown(() {
      sut = null;
      mockStore = null;
    });

    test('Test that store dispatches calls LoadedAddressesAction and IsLoadingAction when loadAddresses gets LoadAddressesAction', () async {
      final mockNextDispatcher = MockNextDispatcher();
      await sut.loadAddresses(mockStore, LoadAddressesAction(), mockNextDispatcher);

      expect(verify(mockStore.dispatch(argThat(isInstanceOf<LoadedAddressesAction>()))).callCount, 1);
      expect(verify(mockStore.dispatch(argThat(isInstanceOf<IsLoadingAction>()))).callCount, 1);
      expect(mockNextDispatcher.actions.length, 1);
      expect(mockNextDispatcher.actions[0], isInstanceOf<IsLoadingAction>());
    });
  });
}
