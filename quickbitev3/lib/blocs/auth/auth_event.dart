import 'package:equatable/equatable.dart';
import '../../models/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthInitializeEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthRegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthRegisterEvent(this.name, this.email, this.password);

  @override
  List<Object> get props => [name, email, password];
}

class AuthLogoutEvent extends AuthEvent {}

class AuthUpdateProfileEvent extends AuthEvent {
  final User updatedUser;

  const AuthUpdateProfileEvent(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];
}

class AuthToggleFavoriteItemEvent extends AuthEvent {
  final String itemId;

  const AuthToggleFavoriteItemEvent(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class AuthToggleFavoriteRestaurantEvent extends AuthEvent {
  final String restaurantId;

  const AuthToggleFavoriteRestaurantEvent(this.restaurantId);

  @override
  List<Object> get props => [restaurantId];
}
