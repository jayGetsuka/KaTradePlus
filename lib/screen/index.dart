import 'package:flutter/material.dart';
import 'package:katradeplus/screen/customer_login.dart';
import 'package:katradeplus/screen/seller_login.dart';

class HomeScreen extends StatelessWidget {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.orange])),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: SizedBox(
              width: double.infinity,
              height: 500,
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "KATRADE PLUS+",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Center(
                        child: Text(
                      "       เป็นแอพขายสินค้าทางการเกษตร สด สะอาด \nปลอดภัย 100% มั่นใจใน KATRADE PLUS",
                      style: TextStyle(fontSize: 17),
                    )),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SellerLog())); // Respond to button press
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            onPrimary: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text(
                            "ขายสินค้า",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Customerlog()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            onPrimary: Colors.black,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15.0),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text(
                            "ซื้อสินค้า",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

void CheckPassword() {}
