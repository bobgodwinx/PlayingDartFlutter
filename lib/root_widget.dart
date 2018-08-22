import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:address_book/AppState.dart';
import 'package:address_book/screens.dart';
import 'package:address_book/home_screen_view_model.dart';
import 'package:address_book/address.dart';

class RootWidget extends StatelessWidget {

  final ViewModelBuilder<HomeScreenViewModel> builder;

  RootWidget({Key key, @required this.builder}) : super(key: key);

  @override
    Widget build(BuildContext context) {
      StoreConnector connector = StoreConnector<AppState, HomeScreenViewModel>(converter: (Store<AppState> store) => HomeScreenViewModel(list: store.state.placemarks, listHandler: (Address address){
        /// here we need to dispatch an action
        print(address);
      }),
                                                distinct: false,
                                                builder: builder,
                                                );
      return connector;
    }



}