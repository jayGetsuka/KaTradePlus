// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:katradeplus/screen/customer_login.dart';

class CustomerRegister extends StatelessWidget {
  const CustomerRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController fullname = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController addr = TextEditingController();
    TextEditingController addr_for_send = TextEditingController();
    TextEditingController pwd = TextEditingController();

    void RegisterCustomer() async {
      const dbName = 'Katradeplus';
      const dbAddress = '10.0.2.2';
      const defaultUri = 'mongodb://$dbAddress:27017/$dbName';

      var db = Db(defaultUri);
      await db.open();

      // ignore: unused_element
      Future cleanupDatabase() async {
        await db.close();
      }

      if (!db.masterConnection.serverCapabilities.supportsOpMsg) {
        return;
      }

      var collectionName = 'customer';
      await db.dropCollection(collectionName);
      var collection = db.collection(collectionName);
      var res = await collection.findOne(where.sortBy('_id', descending: true));
      var id = res!['_id'];
      // ignore: avoid_print
      id++;

      var ret = await collection.insertOne(<String, dynamic>{
        '_id': id,
        'fullname': fullname.text,
        'email': email.text,
        'addr': addr.text,
        'addr_for_send': addr_for_send.text,
        'pwd': pwd.text
      });

      if (!ret.isSuccess) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              // Retrieve the text the that user has entered by using the
              // TextEditingController.
              content: Text('Error detected in record insertion'),
            );
          },
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Customerlog()));
      }
      await cleanupDatabase();
    }

    return Scrollbar(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.green),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "สมัครสมาชิก",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: fullname,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'ชื่อ',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'AvenirLight',
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: email,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'อีเมล',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'AvenirLight',
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: addr,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'ที่อยู่',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'AvenirLight',
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: addr_for_send,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'ที่อยู่สำหรับการจัดส่ง',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'AvenirLight',
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextField(
                        controller: pwd,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'รหัสผ่าน',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'AvenirLight',
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        onPressed: RegisterCustomer,
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'สมัครสมาชิก',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ))));
  }
}
