import 'dart:async';

import 'package:address_book/address.dart';
import 'package:address_book/address_controller.dart';
import 'package:address_book/app_state.dart';
import 'package:address_book/providers/address_provider_type.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

class MockStore extends Mock implements Store<AppState> {}

class MockAddressController extends Mock implements AddressControllerType {}

class MockAddressProvider extends Mock implements AddressProviderType {}

class MockNextDispatcher {
  List<dynamic> actions = List();

  void call(action) {
    actions.add(action);
  }
}
