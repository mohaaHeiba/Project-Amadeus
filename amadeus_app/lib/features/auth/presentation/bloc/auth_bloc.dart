import 'package:amadeus_app/features/auth/domain/usecases/save_operator_name_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SaveOperatorNameUsecase saveOperatorNameUseCase;

  AuthBloc({required this.saveOperatorNameUseCase}) : super(AuthInitial()) {
    on<SaveOperatorNameEvent>(onSaveOperatorName);
  }

  Future<void> onSaveOperatorName(
    SaveOperatorNameEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (event.name.trim().isEmpty) {
      emit(AuthError('Operator name cannot be empty.'));
      return;
    }

    emit(AuthLoading());

    try {
      await saveOperatorNameUseCase(event.name.trim());

      await Future.delayed(const Duration(seconds: 1));

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Failed to establish link.'));
    }
  }
}
