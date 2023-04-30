import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection("chats");

  Future updateData(String name, String email) async {
    return await userCollection
        .doc(uid)
        .set({"Name": name, "Email": email, "Chats": [], "UId": uid});
  }

  Future getData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("Email", isEqualTo: email).get();
    return snapshot;
  }

  getUserChats() async {
    return userCollection.doc(uid).snapshots();
  }
}
