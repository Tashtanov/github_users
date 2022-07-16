part of 'internet_connection_bloc.dart';

abstract class InternetConnectionState extends Equatable {
  const InternetConnectionState();
}

class InternetConnectionInitialState extends InternetConnectionState {
  @override
  List<Object> get props => [];
}
class InternetConnectionSuccessState extends InternetConnectionState {
  @override
  List<Object> get props => [];
}
class InternetConnectionFailureState extends InternetConnectionState {
  @override
  List<Object> get props => [];
}