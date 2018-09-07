import '../address.dart';

typedef AddAddressHandler = void Function(Address address);

class AddAddressViewModel {
  final AddAddressHandler addressHandler;

  AddAddressViewModel({this.addressHandler});

  String cityValidator(String item) => item.isEmpty ? "City is empty" : null;

  String streetValidator(String item) => item.isEmpty ? "Street is empty" : null;
}
