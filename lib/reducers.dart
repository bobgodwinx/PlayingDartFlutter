import 'package:redux/redux.dart';

import 'actions.dart';
import 'address.dart';
import 'app_state.dart';
import 'screen.dart';

/// Contract `StateReducer`
/// must be implemented by the
/// the adoption class.
abstract class StateReducer {
  AppState appStateReducer(AppState state, dynamic action);

  Reducer<List<Address>> placemarksReducer;
  Reducer<bool> loadingReducer;
  Reducer<Screen> screenReducer;
}

///
class ReducerManager implements StateReducer {
  AppState appStateReducer(AppState state, dynamic action) {
    return AppState(
        currentScreen: screenReducer(state.currentScreen, action),
        isLoading: loadingReducer(state.isLoading, action),
        placemarks: placemarksReducer(state.placemarks, action));
  }

  Reducer<List<Address>> placemarksReducer;
  Reducer<bool> loadingReducer;
  Reducer<Screen> screenReducer;

  /// Todo - Come back for dependency injection.
  ReducerManager() {
    /// Placemarks Action closures
    List<Address> addPlacemarks(List<Address> placemarks, AddAddressAction action) =>
        List.of(placemarks)..add(action.address);
    List<Address> loadPlacemarks(List<Address> placemarks, LoadedAddressesAction action) =>
        action.addressList;

    /// Placemarks Reducer
    placemarksReducer = combineReducers<List<Address>>([
      TypedReducer<List<Address>, AddAddressAction>(addPlacemarks),
      TypedReducer<List<Address>, LoadedAddressesAction>(loadPlacemarks),
    ]);

    /// Loading Action closure
    bool loading(bool currentState, LoadAction action) => action.isLoading;

    /// loading Reducer
    loadingReducer = combineReducers<bool>(
        [TypedReducer<bool, LoadAction>(loading), TypedReducer<bool, IsLoadingAction>(loading)]);

    /// screen Action closure
    Screen screen(Screen currentScreen, ScreenUpdateAction action) => action.screen;

    /// Current Screen Reducer
    screenReducer = combineReducers<Screen>([
      TypedReducer<Screen, ScreenUpdateAction>(screen),
    ]);
  }
}
