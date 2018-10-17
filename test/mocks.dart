import 'package:address_book/redux/app_state.dart';
import 'package:address_book/controllers/address_controller.dart';
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
