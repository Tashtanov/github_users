import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'internet_connection_event.dart';

part 'internet_connection_state.dart';

class InternetConnectionBloc
    extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  StreamSubscription? streamSubscription;

  InternetConnectionBloc() : super(InternetConnectionInitialState()) {
    on<OnConnectedEvent>((event, emit) {
      emit(InternetConnectionSuccessState());
    });
    on<OffConnectedEvent>((event, emit) {
      emit(InternetConnectionFailureState());
    });
    streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print("internet connected");
        add(OnConnectedEvent());
      } else
        add(OffConnectedEvent());
    });
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
