import 'address.dart';
import 'screens.dart';

class LoadAddressesAction {}

class LoadCurrentScreenAction {
  final Screens currentScreen;

  LoadCurrentScreenAction({this.currentScreen});
}

class AddAddressAction {
  Address address;
  AddAddressAction(this.address);
}

class LoadAction {
  bool isLoading = true;
}

class IsLoadingAction extends LoadAction {
  @override
  bool isLoading;
  IsLoadingAction(this.isLoading);
}
