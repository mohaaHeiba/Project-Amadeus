import 'package:amadeus_app/core/constants/avatar_emotion.dart';
import 'package:amadeus_app/features/avatar/data/models/rive_input_names.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  AvatarBloc() : super(const AvatarState()) {
    on<ToggleAngryEvent>(_onToggleAngry);
    on<ToggleHandToChestEvent>(_onToggleHandToChest);
    on<ToggleBlushingEvent>(_onToggleBlushing);
    on<ToggleShakingHeadEvent>(_onToggleShakingHead);
    on<ToggleCheckingOnUserEvent>(_onToggleCheckingOnUser);
    on<UpdateMouthValueEvent>(_onUpdateMouthValue);
    on<UpdateEmotionEvent>(_onUpdateEmotion, transformer: restartable());
  }

  void _onToggleAngry(ToggleAngryEvent event, Emitter<AvatarState> emit) {
    emit(state.copyWith(isAngry: event.value));
  }

  void _onToggleHandToChest(
    ToggleHandToChestEvent event,
    Emitter<AvatarState> emit,
  ) {
    emit(state.copyWith(isHandToChest: event.value));
  }

  void _onToggleBlushing(ToggleBlushingEvent event, Emitter<AvatarState> emit) {
    emit(state.copyWith(isBlushing: event.value));
  }

  void _onToggleShakingHead(
    ToggleShakingHeadEvent event,
    Emitter<AvatarState> emit,
  ) {
    emit(state.copyWith(isShakingHead: event.value));
  }

  void _onToggleCheckingOnUser(
    ToggleCheckingOnUserEvent event,
    Emitter<AvatarState> emit,
  ) {
    emit(state.copyWith(isCheckingOnUser: event.value));
  }

  void _onUpdateMouthValue(
    UpdateMouthValueEvent event,
    Emitter<AvatarState> emit,
  ) {
    emit(state.copyWith(mouthValue: event.value));
  }

  Future<void> _onUpdateEmotion(
    UpdateEmotionEvent event,
    Emitter<AvatarState> emit,
  ) async {
    emit(
      AvatarState.fromEmotions(event.emotions, mouthValue: state.mouthValue),
    );

    await Future.delayed(const Duration(seconds: 3));

    emit(
      AvatarState.fromEmotions([
        AvatarEmotion.neutral,
      ], mouthValue: state.mouthValue),
    );
  }
}
