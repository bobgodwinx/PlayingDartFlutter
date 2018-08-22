import 'package:address_book/address.dart';

typedef AddAddressHandler = void Function(Address address);

class HomeScreenViewModel {
  final List<Address> list;
  final AddAddressHandler listHandler;

  HomeScreenViewModel({this.list, this.listHandler});   
}