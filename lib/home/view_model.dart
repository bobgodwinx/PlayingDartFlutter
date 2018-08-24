import '../address.dart';

typedef AddAddressHandler = void Function(Address address);

class HomeScreenViewModel {
  final List<Address> list;
  final AddAddressHandler addressHandler;

  HomeScreenViewModel({this.list, this.addressHandler});
}
