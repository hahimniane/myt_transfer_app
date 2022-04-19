import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money/Screens/input-code_screen.dart';
import 'package:money/Screens/paid_transaction_info_page.dart';
import 'package:money/background.dart';

import 'package:money/firebase/firebase_file.dart';

import '../constants.dart';

// class ReceiveMoneyPage extends StatefulWidget {
//   final String code;
//
//   const ReceiveMoneyPage({required this.code});
//
//   @override
//   _ReceiveMoneyPageState createState() => _ReceiveMoneyPageState();
// }
//
// class _ReceiveMoneyPageState extends State<ReceiveMoneyPage> {
//   FirebaseClass firebaseFunction = FirebaseClass();
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Background(
//         child: SafeArea(
//           child: Center(
//             child: FutureBuilder<DocumentSnapshot>(
//               future:
//                   firestore.collection('Unpaid Transactions').doc(code).get(),
//               builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(
//                     child: Text(snapshot.hasError.toString()),
//                   );
//                 }
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       elevation: 20,
//                       color: cardStyle,
//                       margin: const EdgeInsets.all(10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.02,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Expanded(
//                                 child: Text('CODE:',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   snapshot.data!['Code'],
//                                   style: const TextStyle(fontSize: 20),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.02,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Expanded(
//                                 child: Text('RECEIVER NAME:',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   snapshot.data!['RECEIVER FULL NAME'],
//                                   style: const TextStyle(fontSize: 20),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.02,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Expanded(
//                                 child: Text('PHONE NUMBER:',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   snapshot.data!['RECEIVER PHONE NUMBER'],
//                                   style: const TextStyle(fontSize: 20),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.02,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Expanded(
//                                 child: Text('AMOUNT:',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   '\$' + snapshot.data!['AMOUNT'],
//                                   style: const TextStyle(fontSize: 20),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: MediaQuery.of(context).size.height * 0.02,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Expanded(
//                                 child: Text('ORIGIN:',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   snapshot.data!['ORIGIN'],
//                                   style: const TextStyle(fontSize: 20),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: ElevatedButton(
//                           style: OutlinedButton.styleFrom(
//                             backgroundColor: Colors.orange,
//                             shape: BeveledRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           onLongPress: () {
//                             print(InputCodePage().codeController.text);
//                           },
//                           onPressed: () {},
//                           child: const Text('MAKE PAYMENTS')),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ReceiveMoneyPage extends StatelessWidget {
  final String code;

  ReceiveMoneyPage({Key? key, required this.code}) : super(key: key);

  FirebaseClass firebaseFunction = FirebaseClass();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Center(
            child: StreamBuilder<DocumentSnapshot>(
              stream: firestore
                  .collection('Unpaid Transactions')
                  .doc(code)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.hasError.toString()),
                  );
                } else if (snapshot.hasData && snapshot.data!.exists) {
                  var doc = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 20,
                        color: cardStyle,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text('CODE:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  child: Text(
                                    doc?['Code'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text('RECEIVER NAME:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  child: Text(
                                    doc?['RECEIVER FULL NAME'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text('PHONE NUMBER:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  child: Text(
                                    doc?['RECEIVER PHONE NUMBER'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text('AMOUNT:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  child: Text(
                                    '\$' + snapshot.data!['AMOUNT'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text('ORIGIN:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  child: Text(
                                    doc?['ORIGIN'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text('DESTINATION:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  child: Text(
                                    doc?['DESTINATION'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text('STATUS:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  child: Text(
                                    doc?['STATUS'],
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onLongPress: () {
                              print(InputCodePage().codeController.text);
                            },
                            onPressed: () {
                              firebaseFunction.update(
                                  'Unpaid Transactions',
                                  code,
                                  context,
                                  PaidTransactionInfoPage(
                                    code: code,
                                  ));
                            },
                            child: const Text('MAKE PAYMENTS')),
                      ),
                    ],
                  );
                } else {
                  return const Text('An Error Has Occurred. please try again');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
