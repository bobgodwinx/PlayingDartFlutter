import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';
import 'home/home_screen_view_model.dart';

class RootWidget extends StatelessWidget {
  final ViewModelBuilder<HomeScreenViewModel> builder;

  RootWidget({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var converter = (Store<AppState> store) =>
        HomeScreenViewModel(list: store.state.placemarks);

    StoreConnector connector = StoreConnector<AppState, HomeScreenViewModel>(
      converter: converter,
      distinct: false,
      builder: builder,
    );
    return connector;
  }
}
