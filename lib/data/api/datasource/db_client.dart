import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tryhard_showcase/data/api/datasource/models/exception.dart';
import 'package:tryhard_showcase/data/repositories/user/models/user.dart';
import 'package:tryhard_showcase/data/repositories/user/models/user_info_basic.dart';

import 'db.dart';

class FirebaseApiService implements Database {
  final db = FirebaseFirestore.instance;

  static const String users = 'users';

  @override
  Future<void> createUser({
    required UserRegistrationBasicInfo userInfo,
  }) async {
    try {
      final bool userExists = await _isObjectExists(obj: userInfo);
      if (!userExists) {
        return db.collection(users).doc(userInfo.guid).set(userInfo.toJson());
      }
    } on FirebaseException catch (e) {
      throw ApiException(
        code: e.code,
        description: e.message ?? 'An error occurred on creating user profile',
      );
    } catch (_) {
      throw ApiException(
        code: 'create-user-profile',
        description: 'An error occurred on creating user profile',
      );
    }
  }

  @override
  Future<UserProfile> getUserProfile({
    required String userGuid,
  }) async {
    try {
      final snap = await db.collection(users).doc(userGuid).get();
      final json = snap.data() ?? {};
      return UserProfile.fromJson(json);
    } on FirebaseException catch (e) {
      throw ApiException(
        code: e.code,
        description: e.message ?? 'An error occurred on getting user profile',
      );
    } catch (_) {
      throw ApiException(
        code: 'get-user-profile',
        description: 'An error occurred on getting user profile',
      );
    }
  }

  @override
  Future<void> updateUser({
    required UserProfile? user,
  }) {
    try {
      return db.collection(users).doc(user!.guid).update(user.toJson());
    } on FirebaseException catch (e) {
      throw ApiException(
        code: e.code,
        description: e.message ?? 'An error occurred on updating user profile',
      );
    } catch (_) {
      throw ApiException(
        code: 'update-user-profile',
        description: 'An error occurred on updating user profile',
      );
    }
  }

  @override
  Future<void> deleteUser({
    required String userGuid,
  }) {
    try {
      return db.collection(users).doc(userGuid).delete();
    } on FirebaseException catch (e) {
      throw ApiException(
        code: e.code,
        description: e.message ?? 'An error occurred on updating user profile',
      );
    } catch (_) {
      throw ApiException(
        code: 'update-user-profile',
        description: 'An error occurred on updating user profile',
      );
    }
  }

  Future<bool> _isObjectExists({
    required dynamic obj,
  }) async {
    bool isExists = false;
    String path = '';

    if (obj is UserProfile || obj is UserRegistrationBasicInfo) {
      path = users;
    }
    isExists = await _check(path, obj.guid);
    return isExists;
  }

  Future<bool> _check(
    String path,
    String guid,
  ) {
    try {
      return db.collection(path).doc(guid).get().then((value) => value.exists,
          onError: (_) {
        return false;
      });
    } catch (_) {
      return Future.value(false);
    }
  }
}
