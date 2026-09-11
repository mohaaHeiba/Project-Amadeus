import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SaveOperatorNameEvent>(onSaveOperatorName);
  }
  Future<void> onSaveOperatorName(
    SaveOperatorNameEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (event.name.isEmpty) {
      emit(AuthError('Operator name cannot be empty.'));

      return;
    } else {
      emit(AuthLoading());
      // Simulate a delay for saving the operator name
      await Future.delayed(const Duration(seconds: 2));
      // Here you would typically save the operator name to a repository or database
      emit(AuthSuccess());
    }
  }
}
