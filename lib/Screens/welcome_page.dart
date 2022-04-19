import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money/Screens/input-code_screen.dart';
import 'package:money/Screens/past_trasactions_full.dart';
import 'package:money/Screens/send/send_screen.dart';
import 'package:money/background.dart';

import 'login/login.dart';
import 'receive_money.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
            child: SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.92,
                child: ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SendPage()));
                    },
                    child: const Text('SEND MONEY'))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.92,
              child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InputCodePage()));
                  },
                  child: const Text('RECEIVE MONEY')),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.92,
              child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FullPastTransactionsPage()));
                  },
                  child: const Text('PAST TRANSACTIONS')),
            ),
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                                fullscreenDialog: true)),
                      });
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      ),
    )));
  }
}
