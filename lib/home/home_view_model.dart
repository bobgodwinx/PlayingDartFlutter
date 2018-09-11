import 'package:redux/redux.dart';
import 'package:flutter/cupertino.dart';
import '../app_state.dart';
import '../address.dart';
import '../routes.dart';

class HomeScreenViewModel {
  final List<Address> list;
  final bool isLoading;

  HomeScreenViewModel._internal({this.list, this.isLoading});

  factory HomeScreenViewModel.initWithStore(Store<AppState> store) {
    return HomeScreenViewModel._internal(list: store.state.placemarks, 
                                         isLoading: store.state.isLoading);
  }
}
