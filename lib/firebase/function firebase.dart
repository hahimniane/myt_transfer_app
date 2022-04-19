import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FirebaseFunction {
  Timestamp timestamp = Timestamp.fromDate(DateTime.now());

  Future<int> addNewContainer(
      String collectionNameForCheckingDoc,
      String collectionNameToBeAdded,
      String containerNumber,
      String customerName,
      String shippingLine,
      String destination,
      String prepaidOrCollect,
      DateTime cutOffDate,
      String price) async {
    var exists =
        await checkIfDocExists(collectionNameForCheckingDoc, containerNumber);
    if (!exists) {
      print('has been added');
      firestore
          .collection(collectionNameToBeAdded)
          .doc(containerNumber.toUpperCase())
          .set({
        'PRICE': price.toUpperCase(),
        'BOOKED DATE': DateTime.now(),
        'CONTAINER NUMBER': containerNumber.toUpperCase(),
        'CUSTOMER NAME': customerName.toUpperCase(),
        'SHIPPING LINE': shippingLine.toUpperCase(),
        'DESTINATION': destination.toUpperCase(),
        'PREPAID OR COLLECT': prepaidOrCollect.toUpperCase(),
        'DATE GATED OUT': DateTime.fromMillisecondsSinceEpoch(-2524521600),
        'DATE GATED IN': DateTime.fromMillisecondsSinceEpoch(-2524521600),
        'SHIPPED DATE': DateTime.fromMillisecondsSinceEpoch(-2524521600),
        'CUT OFF DATE': cutOffDate,
      }).then((value) => {
                firestore
                    .collection('past transactions')
                    .doc(containerNumber.toUpperCase())
                    .set({
                  'PRICE': price.toUpperCase(),
                  'BOOKED DATE': DateTime.now(),
                  'CONTAINER NUMBER': containerNumber.toUpperCase(),
                  'CUSTOMER NAME': customerName.toUpperCase(),
                  'SHIPPING LINE': shippingLine.toUpperCase(),
                  'DESTINATION': destination.toUpperCase(),
                  'PREPAID OR COLLECT': prepaidOrCollect.toUpperCase(),
                  'DATE GATED OUT':
                      DateTime.fromMillisecondsSinceEpoch(-2524521600),
                  'DATE GATED IN':
                      DateTime.fromMillisecondsSinceEpoch(-2524521600),
                  'SHIPPED DATE':
                      DateTime.fromMillisecondsSinceEpoch(-2524521600),
                  'CUT OFF DATE': cutOffDate,
                })
              });
      return 0;
    } else {
      print('already exixts. can\'t be added or edited');
      return -1;
    }
  }

  Future<int> addToCategory(
      String collectionTobeAdded,
      String containerNumber,
      String collectionToBeDeletedFrom,
      DateTime dateAddedToTheCollection,
      String fieldName) async {
    //checks if it exists in the previous collection or not. it it does meaning it can be added. else cant't add
    bool existsInpastCollection = await checkIfDocExists(
        collectionToBeDeletedFrom, containerNumber.toUpperCase());
    if (existsInpastCollection) {
      print('exist');
    }

    bool exists = await checkIfDocExists(
        collectionTobeAdded, containerNumber.toUpperCase());
    if (!exists) {
      print('doesnt exist in current current collection');
    }
    if (!exists && existsInpastCollection) {
      print('entered here');
      var cutoffDate = await getParticularFieldInDoc(
          'past transactions', containerNumber.toUpperCase(), 'CUT OFF DATE');

      print('added to $collectionTobeAdded');
      firestore
          .collection(collectionTobeAdded)
          .doc(containerNumber.toUpperCase())
          .set({
            'CONTAINER NUMBER': containerNumber.toUpperCase(),
            fieldName.toUpperCase(): dateAddedToTheCollection,
            'CUT OFF DATE': cutoffDate
          })
          .then((value) => {
                firestore
                    .collection('past transactions')
                    .doc(containerNumber.toUpperCase())
                    .update({
                  fieldName.toUpperCase(): dateAddedToTheCollection,
                })
              })
          .then((value) => {
                firestore
                    .collection(collectionToBeDeletedFrom)
                    .doc(containerNumber.toUpperCase())
                    .delete(),
              });
      return 0;
    } else {
      print(
          'Either container doesnt exist in past transactions or it already exist in the current one ');
      return -1;
    }
  }

  Future<bool> checkIfDocExists(
      String collectionName, String containerNumber) async {
    var collectionRef = firestore.collection(collectionName);

    var doc = await collectionRef.doc(containerNumber.toUpperCase()).get();
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

  String formattedDate(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    var currentDate = DateTime.now();

    var remaining = dateFromTimeStamp.difference(currentDate).inDays + 1;
    if (remaining > 1) {
      return remaining.toString() + ' days remaining';
    } else if (remaining == 1) {
      return remaining.toString() + ' day remaining';
    } else {
      return 'date has passed by ${remaining.toString().replaceRange(0, 1, ' ')}';
    }
  }

  int inInt(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    var currentDate = DateTime.now();

    var remaining = dateFromTimeStamp.difference(currentDate).inDays;

    return remaining + 1;
  }

  showAlertDialog(BuildContext context, String alertMessage) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("BACK"),
      onPressed: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const AdministratorWelcomePage()));
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ALERT"),
      content: Text(alertMessage),
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

  Future<int> deleteFromBothBookedAndPastTransactions(
      String containerNumber) async {
    var exists = await checkIfDocExists(
        'past transactions', containerNumber.toUpperCase());
    if (exists) {
      firestore
          .collection('past transactions')
          .doc(containerNumber.toUpperCase())
          .delete();
      return 0;
    } else {
      return -1;
    }
  }

  String formatDAteForPastTransaction(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy').format(dateFromTimeStamp);
  }

  checkStatus(String reference, String dataToCheckAgainst) async {
    String result = await getParticularFieldInDoc(
        'past transactions', reference, dataToCheckAgainst);
    if (result == 'TRANSACTION NOT YET AVAILABLE') {
      return false;
    } else {
      return true;
    }
  }
}
