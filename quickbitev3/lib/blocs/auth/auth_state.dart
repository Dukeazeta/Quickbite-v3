import 'package:equatable/equatable.dart';
import '../../models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final User user;

  const AuthenticatedState(this.user);

  @override
  List<Object> get props => [user];
}

class UnauthenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileUpdateLoadingState extends AuthState {}

class ProfileUpdateSuccessState extends AuthState {
  final User user;

  const ProfileUpdateSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileUpdateErrorState extends AuthState {
  final String message;

  const ProfileUpdateErrorState(this.message);

  @override
  List<Object> get props => [message];
}
