// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:address_book/reducers.dart';
import 'package:address_book/app_state.dart';
import 'package:address_book/address.dart';
import 'package:address_book/actions.dart';
import 'package:address_book/screens.dart';

main() {
  group('State Reducer', () {
    test('should add an address on AddAddressAction', () {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      expect(store.state.placemarks, [Address.initialAddress()]);

      final address = Address();

      store.dispatch(AddAddressAction(address));

      expect(store.state.placemarks, [Address.initialAddress(), address]);
    });

    test('AddAddressAction should only change placemarks', () {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initialState(),
      );

      final address = Address();

      store.dispatch(AddAddressAction(address));

      AppState expectedState = AppState.initialState();
      expectedState.placemarks.add(address);

      expect(store.state, expectedState);
    });

    test('LoadCurrentScreenAction should set currentScreen', () {
      final appState = AppState.initialState();
      final store = Store<AppState>(
        appStateReducer,
        initialState: appState,
      );
      store.dispatch(LoadCurrentScreenAction(currentScreen: Screens.add));

      AppState expectedState = appState.copyWith(currentScreen: Screens.add);
      expect(store.state, expectedState);
    });

  });
}
