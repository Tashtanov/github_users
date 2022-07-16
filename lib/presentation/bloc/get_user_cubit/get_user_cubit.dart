import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_users/data/model/user_model.dart';
import 'package:github_users/data/repository/user_repository.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit(this.repository) : super(GetUserInitial());
  int page = 10;
  final UserRepository repository;

  void loadUser() async {
    if (state is GetUserLoading) return;
    final currentState = state;
    var oldList = <User>[];
    if (currentState is GetUserLoaded) {
      oldList = currentState.UserList;
    }
    emit(GetUserLoading(oldList, isFirstFetch: page == 10));
    repository.fetchUsers(page).then((newList) {
      page += 10;
      final allUser = (state as GetUserLoading).oldUserList;
      allUser.addAll(newList);
      emit(GetUserLoaded(allUser));
    });
  }
}
