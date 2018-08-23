
import 'package:redux/redux.dart';
import 'package:address_book/actions.dart';
import 'package:address_book/AppState.dart';
import 'package:address_book/address.dart';
import 'package:address_book/screens.dart';


AppState appStateReducer(AppState state, dynamic action) {
  return AppState(currentScreen: _currentScreenReducer(state.currentScreen, action), isLoading: false, placemarks: [Address.initialAddress()]);
}

AppState _loadAction(AppState appState, LoadAddressesAction action) => AppState.initialState();

final _currentScreenReducer = combineReducers<Screens>([
  TypedReducer<Screens, LoadCurrentScreen>(_setCurrentScreen)
]);

Screens _setCurrentScreen(Screens state, LoadCurrentScreen action) {
  return action.currentScreen;
}

bool _setLoading(bool state, action) {
  return false;
}




// List<Middleware<AppState>> createStoreTodosMiddleware([
//   TodosRepository repository = const TodosRepositoryFlutter(
//     fileStorage: const FileStorage(
//       '__redux_app__',
//       getApplicationDocumentsDirectory,
//     ),
//   ),
// ]) {
//   final saveTodos = _createSaveTodos(repository);
//   final loadTodos = _createLoadTodos(repository);

//   return [
//     TypedMiddleware<AppState, LoadTodosAction>(loadTodos),
//     TypedMiddleware<AppState, AddTodoAction>(saveTodos),
//     TypedMiddleware<AppState, ClearCompletedAction>(saveTodos),
//     TypedMiddleware<AppState, ToggleAllAction>(saveTodos),
//     TypedMiddleware<AppState, UpdateTodoAction>(saveTodos),
//     TypedMiddleware<AppState, TodosLoadedAction>(saveTodos),
//     TypedMiddleware<AppState, DeleteTodoAction>(saveTodos),
//   ];
// }

// final loadingReducer = combineReducers<bool>([
//   TypedReducer<bool, TodosLoadedAction>(_setLoaded),
//   TypedReducer<bool, TodosNotLoadedAction>(_setLoaded),
// ]);

// bool _setLoaded(bool state, action) {
//   return false;
// }