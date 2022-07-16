part of 'get_user_cubit.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();
}

class GetUserInitial extends GetUserState {
  @override
  List<Object> get props => [];
}
class GetUserLoading extends GetUserState{
  final List <User> oldUserList;
  final bool isFirstFetch;

  const GetUserLoading(this.oldUserList, {this.isFirstFetch=false });
  @override
  // TODO: implement props
  List<Object> get props => [oldUserList];

}
class GetUserLoaded extends GetUserState{
  final List<User> UserList;
  const GetUserLoaded(this.UserList);
  @override
  // TODO: implement props
  List<Object> get props => [UserList];
}
class GetUserError extends GetUserState{
  final String message;

  const GetUserError({ required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}