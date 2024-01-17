import 'package:cloud_firestore/cloud_firestore.dart';

class Db {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser({required String id, required String name, required String password, required bool gender, required DateTime birth}) async {
    final docUser = _firestore.collection("user").doc(id);

    final user = User(
      id: id,
      name: name,
      password: password,
      gender: gender,
      birth: birth,
    );
    final json = user.toJson();

    await docUser.set(json);
  }

  Future<User?> readUser({required String id}) async{
    try {
      final docUser = FirebaseFirestore.instance.collection('user').doc(id);
      final snapshot = await docUser.get();

      if (snapshot.exists) {
        return User.fromJson(snapshot.data()!);
      } else {
        return null;
      }
    } catch (e) {
      print('Error reading rehab data: $e');
      return null;
    }
  }

  Future<void> writeRehabData({required String id}) async {
    String rehabId = '$id${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}';
    CollectionReference rehabCollection = _firestore.collection('Rehabilitation');

    await rehabCollection.doc(rehabId).set({
      'userId': id,
      'rehabId': rehabId,
      'firstRehab': DateTime.now(),
    });
  }

  Future<void> writeRehabSecondData({required String id}) async {
    String rehabId = '$id${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}';
    CollectionReference rehabCollection = _firestore.collection('Rehabilitation');

    await rehabCollection.doc(rehabId).update({
      'secondRehab': DateTime.now(),
    });
  }

  Future<bool> readRehabData({required String rehabId}) async {
    try {
      CollectionReference rehabCollection = FirebaseFirestore.instance.collection('Rehabilitation');
      DocumentSnapshot rehabSnapshot = await rehabCollection.doc(rehabId).get();

      if (rehabSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error reading rehab data: $e');
      return false;
    }
  }

  Future<DateTime?> readFirstRehab({required String rehabId}) async {
    try {
      CollectionReference rehabCollection = FirebaseFirestore.instance.collection('Rehabilitation');
      DocumentSnapshot rehabSnapshot = await rehabCollection.doc(rehabId).get();

      if (rehabSnapshot.exists) {
        dynamic firstRehabValue = rehabSnapshot['firstRehab'];

        if (firstRehabValue is Timestamp) {
          return firstRehabValue.toDate();
        } else {
          print('Error: firstRehab is not a DateTime');
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error reading firstRehab data: $e');
      return null;
    }
  }

  Future<DateTime?> readSecondRehab({required String rehabId}) async {
    try {
      CollectionReference rehabCollection = FirebaseFirestore.instance.collection('Rehabilitation');
      DocumentSnapshot rehabSnapshot = await rehabCollection.doc(rehabId).get();

      if (rehabSnapshot.exists) {
        dynamic firstRehabValue = rehabSnapshot['secondRehab'];

        if (firstRehabValue is Timestamp) {
          return firstRehabValue.toDate();
        } else {
          print('Error: firstRehab is not a DateTime');
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error reading firstRehab data: $e');
      return null;
    }
  }

}

class User {
  final String id;
  final String name;
  final String password;
  final bool gender;
  final DateTime birth;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.gender,
    required this.birth,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'password': password,
    'birthday': birth,
    'gender': gender,
  };

  static User fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    password: json['password'],
    birth: _convertTimestamp(json['birthday']),
    gender: json['gender'],
  );


  static DateTime _convertTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else {
      // 如果不是 Timestamp，可能是 DateTime 或其他類型，視情況處理
      return timestamp;
    }
  }

}
