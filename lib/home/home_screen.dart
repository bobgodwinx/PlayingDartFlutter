import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import '../app_state.dart';
import '../routes.dart';
import 'view_model.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    StoreConnector connector =  StoreConnector<AppState, HomeScreenViewModel>(converter: converter, 
                                                                              builder: viewModelBuilder, 
                                                                              distinct: false);
    return connector;
  }

  Widget viewModelBuilder(BuildContext context, HomeScreenViewModel viewModel) {
     AppBar appBar = AppBar(title: Text('Berlin'), elevation: 0.0);
     Widget body = _body(context, viewModel);
     return Scaffold(appBar: appBar, body: body, floatingActionButton: _button(context));
   }

  HomeScreenViewModel converter(Store<AppState> store) {
    return HomeScreenViewModel(list: store.state.placemarks, isLoading: store.state.isLoading);
  }

  Widget _body(BuildContext context, HomeScreenViewModel viewModel) {
    return viewModel.isLoading ? _loadingProgress() : _addressList(context, viewModel);
  }

  Widget _loadingProgress() => LinearProgressIndicator();

  Widget _addressList(BuildContext context, HomeScreenViewModel viewModel) {

    Card itemBuilder(BuildContext context, int index) {
      Column colunm = Column(children:[
        Padding(padding: EdgeInsets.all(5.0), child: Text('City: ${viewModel.list[index].city}, Street: ${viewModel.list[index].street}'))
      ]);
      return Card(child: colunm);
    }

    return ListView.builder(itemBuilder: itemBuilder, itemCount: viewModel.list.length);
  }

  Widget _button(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.addAddress);
      },
      child: Icon(Icons.add),
      tooltip: 'some tooltip',
    );
  }
}
