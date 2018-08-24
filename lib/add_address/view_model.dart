import '../address.dart';

typedef AddAddressHandler = void Function(Address address);

class AddAddressViewModel {
  final AddAddressHandler addressHandler;

  AddAddressViewModel({ this.addressHandler});
}
