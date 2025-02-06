part of 'auth_cubit.dart';

enum CurrentAuthState { initial, loading, loaded }

class AuthState extends Equatable {
  const AuthState({
    this.currentAuthState = CurrentAuthState.initial,
  });
  final CurrentAuthState currentAuthState;

  AuthState copyWith({
    CurrentAuthState? currentAuthState,
  }) {
    return AuthState(
      currentAuthState: currentAuthState ?? this.currentAuthState,
    );
  }

  @override
  List<Object> get props => [
        currentAuthState,
      ];
}
