import 'package:flutter/material.dart';
import '../root_widget.dart';
import '../routes.dart';
import 'view_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RootWidget(
        builder: (BuildContext context, HomeScreenViewModel viewModel) {
      AppBar appBar = AppBar(
        title: Text('Berlin'),
        elevation: 0.0,
      );
      Column body = Column(children: [
        _body(context, viewModel),
      ]);
      return Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: _button(context),
      );
    });
  }

  Widget _body(BuildContext context, HomeScreenViewModel viewModel) {
    var children = viewModel.list.map((item) => Text(item.city)).toList();
    Column childView = Column(children: children);
    return Card(child: childView);
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
