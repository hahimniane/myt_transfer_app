import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:money/Screens/welcome_page.dart';

class FirebaseClass {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  signInUser(String email, String password, BuildContext context,
      Widget pageName) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => pageName))
              });
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  saveToUnpaidDatabase(
    String collectionName,
    String docName,
    String senderNameAndLastName,
    String receiverNameAndLastName,
    String senderPhoneNumber,
    String receiverPhoneNumber,
    String amountToBeReceived,
    String origin,
    String destination,
    BuildContext context,
    String alertMessage,
  ) async {
    var exists = await checkIfDocExists(collectionName, docName.toUpperCase());
    bool exists2 =
        await checkIfDocExists('Past Transactions', docName.toUpperCase());
    if (exists) {
      print('the doc exists already');
      print(auth.currentUser?.email.toString());
    } else {
      firestore
          .collection(collectionName)
          .doc(docName.toUpperCase())
          .set({
            'Code': docName.toUpperCase(),
            'SENDER FULL NAME': senderNameAndLastName,
            'RECEIVER FULL NAME': receiverNameAndLastName,
            'SENDER PHONE NUMBER': senderPhoneNumber,
            'RECEIVER PHONE NUMBER': receiverPhoneNumber,
            'AMOUNT': amountToBeReceived,
            'ORIGIN': origin,
            'DESTINATION': destination,
            'TRANSACTION DATE': DateTime.now(),
            'SENDER AGENT': auth.currentUser?.email.toString(),
            'STATUS': 'UNPAID'
          })
          .then((value) => {
                if (!exists2)
                  {
                    firestore
                        .collection('Past Transactions')
                        .doc(docName.toUpperCase())
                        .set({
                      'Code': docName.toUpperCase(),
                      'SENDER FULL NAME': senderNameAndLastName,
                      'RECEIVER FULL NAME': receiverNameAndLastName,
                      'SENDER PHONE NUMBER': senderPhoneNumber,
                      'RECEIVER PHONE NUMBER': receiverPhoneNumber,
                      'AMOUNT': amountToBeReceived,
                      'ORIGIN': origin,
                      'DESTINATION': destination,
                      'TRANSACTION DATE': DateTime.now(),
                      'SENDER AGENT': auth.currentUser?.email.toString(),
                      'STATUS': 'UNPAID',
                      'RECEIVER AGENT': 'NOT YET RECEIVED',
                      'RECEIVED DATE': DateTime.now()
                    })
                  }
              })
          .then((value) => {showAlertDialog(context, alertMessage)});
    }
  }

  update(String collection, String docName, BuildContext context,
      Widget page) async {
    firestore
        .collection('Past Transactions')
        .doc(docName.toUpperCase())
        .update({
          'STATUS': 'PAID',
          'RECEIVER AGENT': auth.currentUser?.email.toString(),
          'RECEIVED DATE': DateTime.now()
        })
        .then((value) => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page))
            })
        .then((value) => {
              firestore
                  .collection('Unpaid Transactions')
                  .doc(docName.toUpperCase())
                  .delete()
            });
  }

  Future<bool> checkIfDocExists(String collectionName, String docName) async {
    var collectionRef = firestore.collection(collectionName);

    var doc = await collectionRef.doc(docName.toUpperCase()).get();
    if (doc.exists == true) {
      return true;
    } else {
      return false;
    }
  }

  getParticularFieldInDoc(
      String collectionName, String containerNumber, String dataToCheck) async {
    var collection = firestore.collection(collectionName);
    var docSnapshot = await collection.doc(containerNumber.toUpperCase()).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();

      // You can then retrieve the value from the Map like this:

      var value = data?[dataToCheck];
      return value;
    }
    return null;
  }

  String dateFormatter(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy').format(dateFromTimeStamp);
  }

  // int inInt(timeStamp) {
  //   var dateFromTimeStamp =
  //       DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
  //   var currentDate = DateTime.now();
  //
  //   var remaining = dateFromTimeStamp.difference(currentDate).inDays;
  //
  //   return remaining + 1;
  // }

  showAlertDialog(BuildContext context, String alertMessage) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("BACK"),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WelcomePage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("ALERT"),
      content: SelectableText(alertMessage),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
