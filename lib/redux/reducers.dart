import 'package:address_book/address.dart';
import 'package:address_book/models/account.dart';
import 'package:address_book/redux/actions.dart';
import 'package:address_book/redux/app_state.dart';
import 'package:address_book/screen.dart';
import 'package:redux/redux.dart';

/// Contract `StateReducer`
/// must be implemented by the
/// the adoption class.
abstract class StateReducer {
  AppState appStateReducer(AppState state, dynamic action);

  Reducer<List<Address>> placemarksReducer;
  Reducer<bool> loadingReducer;
  Reducer<Screen> screenReducer;
  Reducer<User> userReducer;
}

///
class ReducerManager implements StateReducer {
  AppState appStateReducer(AppState state, dynamic action) {
    final currentScreen = screenReducer(state.currentScreen, action);
    final isLoading = loadingReducer(state.isLoading, action);
    final placemarks = placemarksReducer(state.placemarks, action);
    final user = userReducer(state.user, action);
    return AppState(
      currentScreen: currentScreen,
      isLoading: isLoading,
      placemarks: placemarks,
      user: user,
    );
  }

  @override
  Reducer<List<Address>> placemarksReducer;
  @override
  Reducer<bool> loadingReducer;
  @override
  Reducer<Screen> screenReducer;
  @override
  Reducer<User> userReducer;

  /// Todo - Come back for dependency injection.
  ReducerManager() {
    /// Placemarks Action closures
    List<Address> addPlacemarks(
            List<Address> placemarks, AddAddressAction action) =>
        List.of(placemarks)..add(action.address);
    List<Address> loadPlacemarks(
            List<Address> placemarks, LoadedAddressesAction action) =>
        action.addressList;

    /// Placemarks Reducer
    placemarksReducer = combineReducers<List<Address>>([
      TypedReducer<List<Address>, AddAddressAction>(addPlacemarks),
      TypedReducer<List<Address>, LoadedAddressesAction>(loadPlacemarks),
    ]);

    /// Loading Action closure
    bool loading(bool currentState, LoadAction action) => action.isLoading;

    /// loading Reducer
    loadingReducer = combineReducers<bool>([
      TypedReducer<bool, LoadAction>(loading),
      TypedReducer<bool, IsLoadingAction>(loading)
    ]);

    /// screen Action closure
    Screen screen(Screen currentScreen, ScreenUpdateAction action) =>
        action.screen;

    /// Current Screen Reducer
    screenReducer = combineReducers<Screen>([
      TypedReducer<Screen, ScreenUpdateAction>(screen),
    ]);

    userReducer = combineReducers<User>([
      TypedReducer<User, SignUpSucceededAction>(signupUser),
      TypedReducer<User, SignInSucceededAction>(signinUser),
    ]);
  }

  User signupUser(User state, SignUpSucceededAction action) {
    return action.user;
  }

  User signinUser(User state, SignInSucceededAction action) {
    return action.user;
  }
}
