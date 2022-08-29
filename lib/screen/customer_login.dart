import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:katradeplus/screen/homepage.dart';

class Customerlog extends StatelessWidget {
  const Customerlog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController passwd = TextEditingController();
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      username.dispose();
      passwd.dispose();
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: new BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: Container(
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Text(
                        "KATRADE PLUS+",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "ซื้อสินค้า",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: username,
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          ),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: passwd,
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Icon(
                              Icons.password,
                              color: Colors.grey,
                            ),
                          ),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        onPressed: () async {
                          const dbName = 'Katradeplus';
                          const dbAddress = '10.0.2.2';
                          const defaultUri =
                              'mongodb://$dbAddress:27017/$dbName';

                          var db = Db(defaultUri);
                          await db.open();

                          Future cleanupDatabase() async {
                            await db.close();
                          }

                          if (!db.masterConnection.serverCapabilities
                              .supportsOpMsg) {
                            return;
                          }

                          var collectionName = 'customer';
                          await db.dropCollection(collectionName);
                          var collection = db.collection(collectionName);
                          var res = await collection.find({
                            'username': username.text,
                            'pwd': passwd.text
                          }).toList();
                          if (res.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  // Retrieve the text the that user has entered by using the
                                  // TextEditingController.
                                  content: Text("Invalid password or Username"),
                                );
                              },
                            );
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                        },
                      ),
                    ),
                  ]),
                  decoration: BoxDecoration(color: Colors.green),
                ),
              ),
            )));
  }
}
