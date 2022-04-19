import 'package:flutter/material.dart';
import 'package:money/Screens/paid_transaction_info_page.dart';
import 'package:money/Screens/receive_money.dart';

import 'package:money/background.dart';
import 'package:money/firebase/firebase_file.dart';

class InputCodePage extends StatefulWidget {
  InputCodePage({Key? key}) : super(key: key);
  var codeController = TextEditingController();

  @override
  _InputCodePageState createState() => _InputCodePageState();
}

class _InputCodePageState extends State<InputCodePage> {
  FirebaseClass firebaseClass = FirebaseClass();
  var codeController = TextEditingController();
  void _sendDataToSecondScreen(BuildContext context) async {
    String textToSend = codeController.text.toUpperCase();
    bool contains = await firebaseClass.checkIfDocExists(
        'Unpaid Transactions', codeController.text.toUpperCase());
    bool contains2 = await firebaseClass.checkIfDocExists(
        'Past Transactions', codeController.text.toUpperCase());
    if (contains) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReceiveMoneyPage(
              code: textToSend,
            ),
          ));
    } else if (contains2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaidTransactionInfoPage(
              code: textToSend,
            ),
          ));
    } else {
      firebaseClass.showAlertDialog(context, 'THE CODE DOESN\'T EXIST');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: codeController,
                  decoration: const InputDecoration(labelText: "ENTER CODE"),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _sendDataToSecondScreen(context);
                  },
                  child: const Text('CHECK CODE')),
            ],
          ),
        ),
      ),
    );
  }
}
