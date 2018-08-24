import 'address.dart';
import 'screens.dart';

class AppState { 
  final List<Address> placemarks;
  final bool isLoading;
  final Screens currentScreen;

  AppState({this.currentScreen, this.isLoading, this.placemarks = const []});

  factory AppState.initialState() => AppState(currentScreen: Screens.home, isLoading: false, placemarks: [Address.initialAddress()]);

}