part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SaveOperatorNameEvent extends AuthEvent {
  final String name;
  SaveOperatorNameEvent(this.name);
}
