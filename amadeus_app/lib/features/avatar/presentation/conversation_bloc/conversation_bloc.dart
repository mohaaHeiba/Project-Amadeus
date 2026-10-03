import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationInitial()) {
    on<AppReadyEvent>(_onAppReady);
  }

  void _onAppReady(AppReadyEvent event, Emitter<ConversationState> emit) {
    emit(ConversationIdle());
  }
}
