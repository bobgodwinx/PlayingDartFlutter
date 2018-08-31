import '../address.dart';

typedef AddAddressHandler = void Function(Address address);

class HomeScreenViewModel {
  final List<Address> list;
  final AddAddressHandler addressHandler;
  final bool isLoading;

  HomeScreenViewModel({this.list, this.addressHandler, this.isLoading});
}
