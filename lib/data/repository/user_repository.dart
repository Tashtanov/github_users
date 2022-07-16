import 'package:github_users/data/user_service.dart';
import 'package:github_users/data/model/user_model.dart';

class UserRepository {
  final Service service;

  UserRepository(this.service);

  Future<List<User>> fetchUsers(int page) async {
    final user = await service.fetchUsers(page);
    return user.map((e) => User.fromJson(e)).toList();
  }
}
