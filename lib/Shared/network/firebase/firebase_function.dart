import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../model/task_model.dart';
import '../../../model/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTaskesCollection() {
    return FirebaseFirestore.instance
        .collection("Taskes")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTaskesCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTaskes(DateTime date) {
    return getTaskesCollection()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTaskesCollection().doc(id).delete();
  }

  static Future<void> updateTask(TaskModel task) {
    return getTaskesCollection().doc(task.id).update(task.toJson());
  }

  static Future<void> isDone(TaskModel task) async {
    return getTaskesCollection().doc(task.id).update({"isDone": !task.isDone});
  }

  static Future<UserModel?> readUser(String userId) async {
    DocumentSnapshot<UserModel> userDoc =
        await getUserCollection().doc(userId).get();
    return userDoc.data();
  }
}
