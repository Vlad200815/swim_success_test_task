import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pace_selector_event.dart';
part 'pace_selector_state.dart';

class PaceSelectorBloc extends Bloc<PaceSelectorEvent, PaceSelectorState> {
  PaceSelectorBloc() : super(PaceSelectorInitial()) {
    on<PaceSelectorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
