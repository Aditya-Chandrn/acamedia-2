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

  Future startAChat(
    String userName,
    String uid,
    String user2Name,
  ) async {
    DocumentReference chatDocumentReference = await chatCollection.add({
      "user2Name": user2Name,
      "UId": uid,
      "recentMessage": "",
      "chatID": "",
    });

    await chatDocumentReference.update({
      "chatID": chatDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "Chats":
          FieldValue.arrayUnion(["${chatDocumentReference.id}_$user2Name"]),
    });
  }

  // Search by name
  searchByName(String chatName) {
    if (userCollection.where("Name", isEqualTo: chatName).get() != null) {
      return userCollection.where("Name", isEqualTo: chatName).get();
    } 
    else if (userCollection.where("Name".substring(0, "Name".indexOf(" ")),isEqualTo: chatName).get() !=null) {
      return userCollection.where("Name".substring(0, "Name".indexOf(" ")), isEqualTo: chatName).get();
    }
  }
}
