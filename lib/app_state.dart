import 'address.dart';
import 'screen.dart';

class AppState {
  final List<Address> placemarks;
  final bool isLoading;
  final Screen currentScreen;

  AppState({this.currentScreen, this.isLoading, this.placemarks = const []});

  factory AppState.initialState() => AppState(
        currentScreen: Screen.home,
        isLoading: false,
        placemarks: [Address.initialAddress()],
      );

  AppState copyWith({bool isLoading, Screen currentScreen, List placemarks}) {
    return AppState(
        isLoading: isLoading ?? this.isLoading,
        currentScreen: currentScreen ?? this.currentScreen,
        placemarks: placemarks ?? this.placemarks);
  }

  @override
  String toString() {
    return '$placemarks, isLoading: $isLoading, currentScreen: $currentScreen';
  }

  @override
  int get hashCode => placemarks.hashCode ^ isLoading.hashCode ^ currentScreen.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          currentScreen == other.currentScreen &&
          isLoading == other.isLoading &&
          currentScreen == other.currentScreen;
}
