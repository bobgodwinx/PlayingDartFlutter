import 'package:address_book/address.dart';
import 'package:address_book/redux/actions.dart';
import 'package:address_book/redux/app_state.dart';
import 'package:redux/redux.dart';

typedef AddAddressHandler = void Function(Address address);

class AddAddressViewModel {
  final AddAddressHandler addressHandler;

  AddAddressViewModel._internal({this.addressHandler});

  String cityValidator(String item) => item.isEmpty ? "City is empty" : null;

  String streetValidator(String item) => item.isEmpty ? "Street is empty" : null;

  factory AddAddressViewModel.initWithStore(Store<AppState> store) {
    handler(Address address) => store.dispatch(AddAddressAction(address));
    return AddAddressViewModel._internal(addressHandler: handler);
  }
}
