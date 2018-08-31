import 'package:redux/redux.dart';
import 'actions.dart';
import 'app_state.dart';
import 'address.dart';
import 'screens.dart';

AppState appStateReducer(AppState state, dynamic action) {
  List<Address> placemarks = _addressListReducer(state.placemarks, action);
  bool isLoading = _loadingReducer(state.isLoading, action);
  Screens currentScreen = _currentScreenReducer(state.currentScreen, action);

  AppState newState = AppState(
      currentScreen: currentScreen,
      isLoading: isLoading,
      placemarks: placemarks);

  return newState;
}

AppState _loadAction(AppState appState, LoadAddressesAction action) =>
    AppState.initialState();

final _currentScreenReducer = combineReducers<Screens>(
    [TypedReducer<Screens, LoadCurrentScreenAction>(_setCurrentScreen)]);

Screens _setCurrentScreen(Screens state, LoadCurrentScreenAction action) {
  return action.currentScreen;
}

final _addressListReducer = combineReducers<List<Address>>([
  TypedReducer<List<Address>, AddAddressAction>(_addAddress),
  TypedReducer<List<Address>, LoadedAddressesAction>(_loadedAddresses),
]);

List<Address> _loadedAddresses(
    List<Address> addressList, LoadedAddressesAction action) {
  return action.addressList;
}

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
