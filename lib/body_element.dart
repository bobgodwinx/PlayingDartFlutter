import 'package:flutter/material.dart';
import 'package:address_book/assets.dart';
import 'package:address_book/address.dart';

typedef VoidCallbackWithParam = void Function(String);
typedef CallbackParam = void Function(String item);

class BodyElement extends StatelessWidget { 
  List<String> list;
  BodyElement(this.list);
  
  @override
    Widget build(BuildContext context) {
      var children = list.map((item) => Image.asset(item)).toList();
      Column childView = Column(children: children);
      return Card(child: childView);
    }

}

class BodyElementManager extends StatefulWidget {

  final List<String> list;
  final CallbackParam handler;

  BodyElementManager(this.list, this.handler);

  @override
    State<StatefulWidget> createState() {
      return _BodyElementManagerState();
    }
}

class _BodyElementManagerState extends State<BodyElementManager> {

  List<String> _list;
  CallbackParam _handler;
  
  @override
  void initState() {
    _list = widget.list;
    _handler = widget.handler;
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
      /// button receives a Function(String) Type of arguement.
      BodyControl button = BodyControl(handler: _handleTap);
      return Column(children: [BodyElement(_list), button]);
    }

    void _handleTap(String item) {
      setState(() {
          print(item);
          _handler(item);
      });
    }

  //  Widget addButton(BuildContext context) { 
  //    Color color = Theme.of(context).primaryColor;
  //    RaisedButton button = RaisedButton(child: Text('Add'), onPressed: (){ setState(_handler); }, color: color);
  //    return Container(margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0), child: button);
  //   }

    @override
      void didUpdateWidget(BodyElementManager oldWidget) {
        super.didUpdateWidget(oldWidget);
      }
}

class BodyControl extends StatelessWidget {
  /// This is called lifting the state
  /// you actual separate things into a 
  /// different Widget.
  
  final Function(String) handler;
  
  BodyControl({this.handler});

  @override
  Widget build(BuildContext context) {
      Color color = Theme.of(context).primaryColor;
     RaisedButton button = RaisedButton(child: Text('Add'), onPressed: () => handler(Assets.connect), color: color);
     return Container(margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0), child: button);
  }
  
}

