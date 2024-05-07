import 'package:flutter_bloc/flutter_bloc.dart';

// Define events
abstract class LoaderEvent {}

class ShowLoaderEvent extends LoaderEvent {}

class HideLoaderEvent extends LoaderEvent {}

// Define Bloc
class LoaderBloc extends Bloc<LoaderEvent, bool> {
  LoaderBloc() : super(false) {
    on<LoaderEvent>((event, emit) {
      if (event is ShowLoaderEvent) {
        emit(true); // Emit true to indicate loading
      } else if (event is HideLoaderEvent) {
        emit(false); // Emit false to indicate not loading
      }
    });
  }
}
