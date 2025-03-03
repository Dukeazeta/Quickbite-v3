import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailPassword extends AuthEvent {
  final String email;
  final String password;

  const LoginWithEmailPassword(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginWithEmailPassword>(_onLoginWithEmailPassword);
  }

  Future<void> _onLoginWithEmailPassword(
    LoginWithEmailPassword event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      // TODO: Implement actual authentication logic
      await Future.delayed(const Duration(seconds: 2)); // Simulated delay
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}