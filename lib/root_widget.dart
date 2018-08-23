import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:address_book/app_state.dart';
import 'package:address_book/home_screen_view_model.dart';
import 'package:address_book/address.dart';
import 'package:address_book/actions.dart';

class RootWidget extends StatelessWidget {
  final ViewModelBuilder<HomeScreenViewModel> builder;

  RootWidget({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var converter =  (Store<AppState> store) => HomeScreenViewModel(
          list: store.state.placemarks,
          addressHandler: (Address address) {
            /// here we need to dispatch an action
            store.dispatch(AddAddressAction(address));
          });

    StoreConnector connector = StoreConnector<AppState, HomeScreenViewModel>(
      converter: converter,
      distinct: false,
      builder: builder,
    );
    return connector;
  }
}
