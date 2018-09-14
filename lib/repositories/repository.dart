import '../address.dart';

abstract class Repository {
  loadAddressList();
  addAddress(Address address);
}
