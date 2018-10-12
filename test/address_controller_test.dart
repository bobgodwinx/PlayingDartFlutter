import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:address_book/actions.dart';
import 'package:address_book/controllers/address_controller.dart';
import 'package:address_book/address.dart';

import 'mocks.dart';

main() {
  group('AddressController', () {
    MockStore mockStore;
    AddressController sut;
    MockAddressProvider mockAddressProvider;
    MockNextDispatcher mockNextDispatcher;

    setUp(() {
      mockAddressProvider = MockAddressProvider();
      sut = AddressController(mockAddressProvider);
      mockStore = MockStore();
      mockNextDispatcher = MockNextDispatcher();
    });

    tearDown(() {
      sut = null;
      mockStore = null;
    });

    test('Test that store dispatches calls LoadedAddressesAction and IsLoadingAction when loadAddresses gets LoadAddressesAction', () async {
      final address = Address(city: 'Yerevan', number: 39, street: 'Paul-Linke Ufer');
      when(mockAddressProvider.load()).thenAnswer((_) async => [address]);
          
      await sut.loadAddresses(mockStore, LoadAddressesAction(), mockNextDispatcher);

      expect(verify(mockStore.dispatch(argThat(isInstanceOf<LoadedAddressesAction>()))).callCount, 1);
      expect(verify(mockStore.dispatch(argThat(isInstanceOf<IsLoadingAction>()))).callCount, 1);
      expect(mockNextDispatcher.actions.length, 1);
      expect(mockNextDispatcher.actions[0], isInstanceOf<IsLoadingAction>());
    });

    test('Test that store dispatches LoadedAddressesAction with the provided address list', () async {
      final address = Address(city: 'Yerevan', number: 39, street: 'Paul-Linke Ufer');
      when(mockAddressProvider.load()).thenAnswer((_) async => [address]);
          
      await sut.loadAddresses(mockStore, LoadAddressesAction(), mockNextDispatcher);

      LoadedAddressesAction loadedAddressesAction = verify(mockStore.dispatch(captureAny)).captured.first;

      expect(loadedAddressesAction.addressList.length, 1);
      expect(loadedAddressesAction.addressList[0], address);
    });
    
  });
}
