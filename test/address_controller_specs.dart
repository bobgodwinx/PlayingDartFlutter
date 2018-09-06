import 'package:flutter_test/flutter_test.dart';
import 'package:address_book/midlwares.dart';
import 'package:address_book/actions.dart';
import 'package:mockito/mockito.dart';
import 'mocks.dart';

main() {
  group('AddressController', () {
    MockStore store;
    AddressController sut;

    setUp(() {
      sut = AddressController(MockAddressProvider());
      store = MockStore();
    });

    tearDown(() {
      sut = null;
      store = null;
    });

    test('Test that store dispatches calls LoadedAddressesAction and IsLoadingAction when loadAddresses gets LoadAddressesAction', () async {
      final mockNextDispatcher = MockNextDispatcher();
      await sut.loadAddresses(store, LoadAddressesAction(), mockNextDispatcher);

      expect(verify(store.dispatch(argThat(isInstanceOf<LoadedAddressesAction>()))).callCount, 1);
      expect(verify(store.dispatch(argThat(isInstanceOf<IsLoadingAction>()))).callCount, 1);
      expect(mockNextDispatcher.actions.length, 1);
      expect(mockNextDispatcher.actions[0], isInstanceOf<IsLoadingAction>());
    });
  });
}
