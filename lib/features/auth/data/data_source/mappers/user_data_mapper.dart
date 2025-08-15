import 'package:codebase_assignment/features/auth/data/models/user_model.dart';
import 'package:codebase_assignment/features/auth/domain/entity/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension UserDataMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(uid: uid, email: email, name: name);
  }
}

extension UserCredentialDataMapper on UserCredential {
  UserEntity toEntity() {
    return UserEntity(uid: user?.uid ?? "", email: user?.email ?? "", name: user?.displayName ?? "");
  }
}

extension UserEntityDataMapper on UserEntity {
  UserModel toDto() {
    return UserModel(uid: uid, email: email, name: name);
  }
}
