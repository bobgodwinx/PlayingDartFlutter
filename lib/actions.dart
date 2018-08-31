import 'address.dart';
import 'screen.dart';

class LoadAddressesAction {}

class ScreenUpdateAction {
  final Screen screen;
  ScreenUpdateAction({this.screen});
}

class LoadedAddressesAction {
  final List<Address> addressList;
  LoadedAddressesAction(this.addressList);
}

class AddAddressAction {
  final Address address;
  AddAddressAction(this.address);
}

class LoadAction {
  final bool isLoading = true;
}

class IsLoadingAction extends LoadAction {
  @override
  final bool isLoading;
  IsLoadingAction(this.isLoading);
}
