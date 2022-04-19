import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:money/background.dart';
import 'package:money/firebase/firebase_file.dart';

class SendPage extends StatefulWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  FirebaseClass firebaseClass = FirebaseClass();
  TextEditingController senderFullName = TextEditingController();
  TextEditingController receiverFullName = TextEditingController();
  TextEditingController senderPhoneNumber = TextEditingController();
  TextEditingController receiverPhoneNumber = TextEditingController();
  TextEditingController amountToBeReceived = TextEditingController();
  TextEditingController origin = TextEditingController();
  TextEditingController destination = TextEditingController();

  codeGenerator() {
    var code = senderFullName.text.substring(0, 2).toUpperCase() +
        receiverFullName.text.substring(0, 2).toUpperCase() +
        senderFullName.text
            .substring(
                senderFullName.text.length - 2, senderFullName.text.length)
            .toUpperCase() +
        DateTime.now().minute.toString() +
        receiverPhoneNumber.text
            .substring(receiverPhoneNumber.text.length - 2,
                receiverPhoneNumber.text.length)
            .toUpperCase() +
        destination.text.substring(0, 3).toUpperCase();
    return code;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: senderFullName,
                  decoration: InputDecoration(
                      labelText: FirebaseAuth.instance.currentUser!.email ==
                              'barrypolo96@gmail.com'
                          ? 'Nom et prénom de l\'expéditeur'
                          : "sender name and last name"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: receiverFullName,
                  decoration: InputDecoration(
                      labelText: FirebaseAuth.instance.currentUser!.email ==
                              'barrypolo96@gmail.com'
                          ? 'Nom et prénom de destinataire'
                          : "Reciever name and last name"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: senderPhoneNumber,
                  decoration: InputDecoration(
                      labelText: FirebaseAuth.instance.currentUser!.email ==
                              'barrypolo96@gmail.com'
                          ? 'numéro de téléphone de l\'expéditeur'
                          : "Sender phone number"),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: receiverPhoneNumber,
                  decoration: InputDecoration(
                      labelText: FirebaseAuth.instance.currentUser!.email ==
                              'barrypolo96@gmail.com'
                          ? 'Numéro de téléphone de receveur'
                          : "Receiver phone Number"),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: amountToBeReceived,
                  decoration: InputDecoration(
                      labelText: FirebaseAuth.instance.currentUser!.email ==
                              'barrypolo96@gmail.com'
                          ? 'montant payé en \$'
                          : "Amount to be received  in \$"),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: origin,
                  decoration: InputDecoration(
                      labelText: FirebaseAuth.instance.currentUser!.email ==
                              'barrypolo96@gmail.com'
                          ? 'origine de l\'argent'
                          : "origin of the money "),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: destination,
                  decoration: InputDecoration(
                      labelText: FirebaseAuth.instance.currentUser!.email ==
                              'barrypolo96@gmail.com'
                          ? 'destination de l\'argent'
                          : "destination of the money "),
                ),
              ),

              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () {
                    firebaseClass.saveToUnpaidDatabase(
                        'Unpaid Transactions',
                        codeGenerator(),
                        senderFullName.text,
                        receiverFullName.text,
                        senderPhoneNumber.text,
                        receiverPhoneNumber.text,
                        amountToBeReceived.text,
                        origin.text,
                        destination.text,
                        context,
                        codeGenerator() + ' ');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: EdgeInsets.all(0),
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email ==
                              'barrypolo96@gmail.com'
                          ? "envoyé"
                          : 'SEND',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // Container(
              //   alignment: Alignment.centerRight,
              //   margin:
              //   const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              //   child: GestureDetector(
              //     onTap: () => {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => LoginScreen()))
              //     },
              //     child: const Text(
              //       "Already Have an Account? Sign in",
              //       style: TextStyle(
              //         fontSize: 12,
              //         fontWeight: FontWeight.bold,
              //         color: Color(0xFF2661FA),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
