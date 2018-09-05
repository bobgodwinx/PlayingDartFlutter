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

class AddressProviderMock implements AddressProviderType{
  List<Address> addressList = [Address(city: 'Berlin', street: 'Walkenstrasse', number: 10)];

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

  TestLogger(){}

  log(Call functionCall) {
    logs.add(functionCall);
  }
}

class MockStore extends Store<AppState> {

  TestLogger logger;

  MockStore({this.logger, MiddlewareManager manager}) : super(
    ReducerManager().appStateReducer, 
    initialState: AppState.initialState(), 
    middleware: manager.middlewares(),
  );

  @override
    void dispatch(dynamic action) {
      Call call = Call(functionName: "hello", parameters: [action]);
      logger.log(call);
      super.dispatch(action);
  }
}
main() {
  group('MiddlewareManager', () {

    TestLogger logger;
    MockStore store;
    MiddlewareManager sut;
    
    setUp(() {
      logger = TestLogger();
      sut = MiddlewareManager(addressProvider: AddressProviderMock());
      store = MockStore(logger: logger, manager: sut);
    });

    tearDown(() {
      logger = null;
      sut = null;
      store = null;
    });

    test('middleware to make 2 store dispatch calls when loadAddresses gets LoadAddressesAction', () async {
      await sut.middlewares()[0](store, LoadAddressesAction(), (IsLoadingAction){});
      expect(logger.logs.length, 2);
    });

    test('middleware to make 0 store dispatch calls when loadAddresses gets the wronge Action', () async {
      await sut.middlewares()[0](store, IsLoadingAction, (IsLoadingAction){});
      expect(logger.logs.length, 0);
    });
  });
}
