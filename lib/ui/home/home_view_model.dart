import 'package:address_book/address.dart';
import 'package:address_book/redux/app_state.dart';
import 'package:redux/redux.dart';

class HomeScreenViewModel {
  final List<Address> list;
  final bool isLoading;

  HomeScreenViewModel._internal({this.list, this.isLoading});

  factory HomeScreenViewModel.initWithStore(Store<AppState> store) {
    return HomeScreenViewModel._internal(
        list: store.state.placemarks, isLoading: store.state.isLoading);
  }
}
