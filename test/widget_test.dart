// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:address_book/address.dart';
import 'package:address_book/redux/app_state.dart';
import 'package:address_book/redux/reducers.dart';
import 'package:address_book/ui/add_address/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

class AddressBookApp extends StatelessWidget {
  final Store<AppState> store = Store(
    ReducerManager().appStateReducer,
    initialState: AppState.initialState(),
  );

  @override
  Widget build(BuildContext context) {
    Widget addAddress = StoreBuilder<AppState>(
        onInit: (Store<AppState> store) {}, builder: (context, store) => AddAddressScreen());

    MaterialApp child = MaterialApp(title: 'Hello', routes: {'/': (context) => addAddress});
    return StoreProvider(store: store, child: child);
  }
}

final cityValidatorMsg = 'City is empty';
final streetValidatorMsg = 'Street is empty';

void main() {
  group('widget test', () {
    // TODO Widget test is broken
    testWidgets('Adds a new address to address list and changes the State',
        (WidgetTester tester) async {
      final app = AddressBookApp();
      await tester.pumpWidget(app);

      final city = 'Yerevan';
      final street = 'Abovyan';

      await tester.enterText(find.byKey(AddAddressScreen.cityKey), city);
      await tester.enterText(find.byKey(AddAddressScreen.streetKey), street);

      await tester.tap(find.byType(RaisedButton));
      await tester.pump();

      expect(find.text(streetValidatorMsg), findsNothing);
      expect(find.text(cityValidatorMsg), findsNothing);

      AppState expectedState = AppState.initialState();
      expectedState.placemarks.add(Address(city: city, street: street));

      expect(app.store.state.currentScreen, expectedState.currentScreen);
      expect(app.store.state.isLoading, expectedState.isLoading);
      expect(app.store.state.placemarks.length, expectedState.placemarks.length);
    });

    testWidgets('City and street validator test', (WidgetTester tester) async {
      await tester.pumpWidget(AddressBookApp());

      await tester.tap(find.byType(RaisedButton));

      await tester.pump();
      expect(find.text(cityValidatorMsg), findsOneWidget);
      expect(find.text(streetValidatorMsg), findsOneWidget);
    });
  });
}
