part of 'profile_cubit.dart';

enum CurrentUpdateState { initial, loading, loaded }

enum CurrentLogoutState { initial, loading, loaded }

class ProfileState extends Equatable {
  const ProfileState({
    this.currentUpdateState = CurrentUpdateState.initial,
    this.currentLogoutState = CurrentLogoutState.initial,
  });
  final CurrentUpdateState currentUpdateState;
  final CurrentLogoutState currentLogoutState;

  ProfileState copyWith({
    CurrentUpdateState? currentUpdateState,
    CurrentLogoutState? currentLogoutState,
  }) {
    return ProfileState(
      currentUpdateState: currentUpdateState ?? this.currentUpdateState,
      currentLogoutState: currentLogoutState ?? this.currentLogoutState,
    );
  }

  @override
  List<Object> get props => [
        currentUpdateState,
        currentLogoutState,
      ];
}
