import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';
import 'home/view_model.dart';

class RootWidget extends StatelessWidget {
  final ViewModelBuilder<HomeScreenViewModel> builder;

  RootWidget({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// StoreConverter
    var converter = (Store<AppState> store) { 
      return  HomeScreenViewModel(list: store.state.placemarks, isLoading: store.state.isLoading); 
    };
    /// StoreConnector
    StoreConnector connector = StoreConnector<AppState, HomeScreenViewModel>(
      converter: converter,
      distinct: false,
      builder: builder,
    );
    return connector;
  }
}
