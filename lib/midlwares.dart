import 'package:redux/redux.dart';

import 'app_state.dart';

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  print(store.state);
  print('action: $action');

  next(action);
}
