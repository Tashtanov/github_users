part of 'internet_connection_bloc.dart';

abstract class InternetConnectionEvent extends Equatable {
  const InternetConnectionEvent();
}
class OnConnectedEvent extends InternetConnectionEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class OffConnectedEvent extends InternetConnectionEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
