import 'package:address_book/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:address_book/redux/app_state.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Returns a StatelessWidget that is updatable
    /// Has access to current State<AppState>
    return StoreConnector<AppState, HomeScreenViewModel>(
        converter: _converter, builder: _builder, distinct: false);
  }

  /// Returns a Widget or View when given a context + viewModel
  Widget _builder(BuildContext context, HomeScreenViewModel viewModel) {
    AppBar appBar = AppBar(title: Text('Berlin'), elevation: 0.0);
    Widget body = _body(context, viewModel);
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: _button(context, viewModel),
    );
  }

  /// Returns a viewModel when given a store
  HomeScreenViewModel _converter(Store<AppState> store) => HomeScreenViewModel.initWithStore(store);

  Widget _body(BuildContext context, HomeScreenViewModel viewModel) {
    return viewModel.isLoading ? _loadingProgress() : _addressList(context, viewModel);
  }

  Widget _loadingProgress() => LinearProgressIndicator();

  Widget _addressList(BuildContext context, HomeScreenViewModel viewModel) {
    Card itemBuilder(BuildContext context, int index) {
      Column column = Column(children: [
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
            'City: ${viewModel.list[index].city}, Street: ${viewModel.list[index].street}',
          ),
        )
      ]);
      return Card(child: column);
    }

    return ListView.builder(itemBuilder: itemBuilder, itemCount: viewModel.list.length);
  }

  Widget _button(BuildContext context, HomeScreenViewModel viewModel) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, Routes.addAddress),
      child: Icon(Icons.add),
      tooltip: 'some tooltip',
    );
  }
}
