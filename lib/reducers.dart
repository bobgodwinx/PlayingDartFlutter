import 'package:redux/redux.dart';
import 'actions.dart';
import 'app_state.dart';
import 'address.dart';
import 'screens.dart';

AppState appStateReducer(AppState state, dynamic action) {
  AppState newState = AppState(
      currentScreen: _currentScreenReducer(state.currentScreen, action),
      isLoading: _loadingReducer(state.isLoading, action),
      placemarks: _addressListReducer(state.placemarks, action));
  return newState;
}

AppState _loadAction(AppState appState, LoadAddressesAction action) =>
    AppState.initialState();

final _currentScreenReducer = combineReducers<Screens>(
    [TypedReducer<Screens, LoadCurrentScreen>(_setCurrentScreen)]);

Screens _setCurrentScreen(Screens state, LoadCurrentScreen action) {
  return action.currentScreen;
}

final _addressListReducer = combineReducers<List<Address>>(
    [TypedReducer<List<Address>, AddAddressAction>(_addAddress)]);

List<Address> _addAddress(List<Address> addressList, AddAddressAction action) {
  addressList.add(action.address);
  return addressList;
}

final _loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadAction>(_setLoading),
  TypedReducer<bool, IsLoadingAction>(_setLoading)
]);

bool _setLoading(bool state, LoadAction action) {
  return action.isLoading;
}
