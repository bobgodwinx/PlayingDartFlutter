import 'package:address_book/address.dart';
import 'package:address_book/models/account.dart';
import 'package:address_book/screen.dart';

class AppState {
  final List<Address> placemarks;
  final bool isLoading;
  final Screen currentScreen;
  final User user;

  AppState(
      {this.currentScreen,
      this.isLoading,
      this.placemarks = const [],
      this.user});

  factory AppState.initialState() => AppState(
        currentScreen: Screen.home,
        isLoading: false,
        placemarks: [Address.initialAddress()],
        user: null
      );

  AppState copyWith({bool isLoading, Screen currentScreen, List placemarks}) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      currentScreen: currentScreen ?? this.currentScreen,
      placemarks: placemarks ?? this.placemarks,
      user: user ?? this.user,
    );
  }

  @override
  String toString() =>
      '$placemarks, isLoading: $isLoading, currentScreen: $currentScreen';

  @override
  int get hashCode =>
      placemarks.hashCode ^ isLoading.hashCode ^ currentScreen.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          currentScreen == other.currentScreen &&
          isLoading == other.isLoading &&
          placemarks == other.placemarks &&
          user == other.user;
}
