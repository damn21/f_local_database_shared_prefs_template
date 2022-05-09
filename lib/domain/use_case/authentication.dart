import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entities/random_user.dart';
import '../repositories/user_repository.dart';

// this file handles the business logic, calling the corresponding repository
class Authentication {
  UserRepository repository = Get.find();

  Future<bool> get init async => await repository.init();

  Future<void> addUser(email, password) async {
    await repository.addUser(User(email: email, password: password));
  }
      

  // if login is ok then data is stored on shared prefs
  Future<bool> login(storeUser, email, password) async {
    
    List<User> _users = await repository.getAllUsers();
    var user= _users.firstWhereOrNull((element) => element.email==email && element.password==password);
    print(user);
        if(user == null){
         return Future.value(false);
    }else{
      return Future.value(true);
    }
  }

  Future<void> signup(user, password) async {
    await repository.signup(User(email: user, password: password));
  }

  Future<void> logout() async {
    return await repository.logout();
  }

  Future<User> getStoredUser() async {
    return await repository.getStoredUser().onError((error, stackTrace) {
      return User(email: "", password: "");
    });
  }

  Future<void> clearStoredUser() async {
    return await repository.clearStoredUser();
  }

  clearAll() async {
    await repository.clearAll();
  }

  Future<bool> isStoringUser() async {
    return repository.isStoringUser();
  }
}
