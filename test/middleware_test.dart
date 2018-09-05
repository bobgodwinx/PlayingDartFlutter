import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:address_book/midlwares.dart';
import 'package:address_book/app_state.dart';
import 'package:address_book/address.dart';
import 'package:address_book/actions.dart';
import 'package:address_book/screen.dart';
import 'package:address_book/providers/address_provider_type.dart';
import 'package:mockito/mockito.dart';
// class AddressProviderMock implements AddressProviderType{
//    List<Address> addressList = [
//     Address(city: 'Berlin', street: 'Walkenstrasse', number: 10),
//     Address(city: 'Yerevan', street: 'Koryun', number: 7),
//     Address(city: 'Berlin', street: 'paul-lincke-uffer', number: 39),
//   ];

//   AddressProviderMock() {}

//   factory AddressProviderMock.instance() => AddressProviderMock();

//   Future<List<Address>> load() async {
//     // throw Exception('an error!');
//     return addressList;
//   }

//   Future<bool> save() async {
//     return true;
//   }
// }

class AddressProviderMock extends Mock implements AddressProviderType {}

main() {
  group('MiddlewareManager', () {
    final middlewareManager =
        MiddlewareManager(addressProvider: AddressProviderMock());
    final middlewaresCount = 2;
    test('middlewares count should be $middlewaresCount', () {
      expect(middlewareManager.middlewares().length, middlewaresCount);
    });

    //   test('AddAddressAction should only change placemarks', () {
    //     final store = Store<AppState>(
    //       appStateReducer,
    //       initialState: AppState.initialState(),
    //     );

    //     final address = Address();

    //     store.dispatch(AddAddressAction(address));

    //     AppState expectedState = AppState.initialState();
    //     expectedState.placemarks.add(address);

    //     expect(store.state, expectedState);
    //   });

    //   test('LoadCurrentScreenAction should set currentScreen', () {
    //     final appState = AppState.initialState();
    //     final store = Store<AppState>(
    //       appStateReducer,
    //       initialState: appState,
    //     );
    //     store.dispatch(ScreenUpdateAction(screen: Screen.add));

    //     AppState expectedState = appState.copyWith(currentScreen: Screen.add);
    //     expect(store.state, expectedState);
    //   });
    // });
  });
}
