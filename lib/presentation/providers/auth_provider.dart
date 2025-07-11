import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/domain/models/user_model.dart';

import '../../core/constants/app_constants.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
      return AuthNotifier();
    });

class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  AuthNotifier() : super(const AsyncValue.loading()) {
    _init();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _init() {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        try {
          final userDoc =
              await _firestore
                  .collection(AppConstants.usersCollection)
                  .doc(user.uid)
                  .get();

          if (userDoc.exists) {
            final userModel = UserModel.fromFirestore(userDoc);
            state = AsyncValue.data(userModel);
          } else {
            state = const AsyncValue.data(null);
          }
        } catch (e) {
          state = AsyncValue.error(e, StackTrace.current);
        }
      } else {
        state = const AsyncValue.data(null);
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  bool hasRole(String role) {
    return state.value?.role == role;
  }

  bool hasAnyRole(List<String> roles) {
    return state.value != null && roles.contains(state.value!.role);
  }
}
