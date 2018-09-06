import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:address_book/midlwares.dart';
import 'package:address_book/app_state.dart';
import 'package:address_book/address.dart';
import 'package:address_book/actions.dart';
import 'package:address_book/screen.dart';
import 'package:address_book/providers/address_provider_type.dart';
import 'package:mockito/mockito.dart';
import 'package:address_book/reducers.dart';

class AddressProviderMock implements AddressProviderType {
  List<Address> addressList = [
    Address(city: 'Berlin', street: 'Walkenstrasse', number: 10)
  ];

  AddressProviderMock() {}

  factory AddressProviderMock.instance() => AddressProviderMock();

  Future<List<Address>> load() async {
    return addressList;
  }

  Future<bool> save() async {
    return true;
  }
}

class Call {
  String functionName;
  List<dynamic> parameters;

  Call({this.functionName, this.parameters = const []});
}

class TestLogger {
  List<Call> logs = [];

  TestLogger() {}

  log(Call functionCall) {
    logs.add(functionCall);
  }
}

// class MockStore extends Store<AppState> {
//   TestLogger logger;

//   MockStore({this.logger, MiddlewareManager manager})
//       : super(
//           ReducerManager().appStateReducer,
//           initialState: AppState.initialState(),
//           middleware: manager.middlewares(),
//         );

//   @override
//   void dispatch(dynamic action) {
//     Call call = Call(functionName: "hello", parameters: [action]);
//     logger.log(call);
//     super.dispatch(action);
//   }
// }

class MockMiddlewareManager extends Mock implements MiddlewareClass {}

class MockStore extends Mock implements Store<AppState> {}

class MockNextDispatcher {
  List<dynamic> actions = List();

  void call(action) {
    actions.add(action);
  }
}

main() {
  group('MiddlewareManager', () {
    TestLogger logger;
    MockStore store;
    AddressController sut;

    setUp(() {
      sut = AddressController(AddressProviderMock());
      // store = MockStore(logger: logger, manager: sut);
      store = MockStore();
    });

    tearDown(() {
      logger = null;
      sut = null;
      store = null;
    });

    test(
        'middleware to make 2 store dispatch calls when loadAddresses gets LoadAddressesAction',
        () async {
      final mockNextDispatcher = MockNextDispatcher();
      await sut.loadAddresses(store, LoadAddressesAction(), mockNextDispatcher);

      expect(
          verify(store.dispatch(argThat(isInstanceOf<LoadedAddressesAction>())))
              .callCount,
          1);
      expect(
          verify(store.dispatch(argThat(isInstanceOf<IsLoadingAction>())))
              .callCount,
          1);

      expect(mockNextDispatcher.actions.length, 1);
      expect(mockNextDispatcher.actions[0], isInstanceOf<IsLoadingAction>());
    });
  });
}
