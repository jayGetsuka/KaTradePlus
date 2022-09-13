// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:katradeplus/screen/seller_login.dart';

class SellerRegister extends StatelessWidget {
  const SellerRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController storeName = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController storeAddr = TextEditingController();
    TextEditingController pwd = TextEditingController();

    // ignore: non_constant_identifier_names
    void RegisterSeller() async {
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

      var collectionName = 'seller';
      await db.dropCollection(collectionName);
      var collection = db.collection(collectionName);
      var res = await collection.findOne(where.sortBy('_id', descending: true));
      var id = res!['_id'];
      // ignore: avoid_print
      if (id == null) {
        id = 1;
      } else {
        id++;
      }

      var ret = await collection.insertOne(<String, dynamic>{
        '_id': id,
        'store_name': storeName.text,
        'email': email.text,
        'store_addr': storeAddr.text,
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
            MaterialPageRoute(builder: (context) => const SellerLog()));
      }
      await cleanupDatabase();
    }

    return Scrollbar(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            // ignore: avoid_unnecessary_containers
            body: Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 1,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.green),
                  child: Column(children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
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
                        controller: storeName,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'ชื่อร้านค้า',
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
                        controller: storeAddr,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'ที่อยู่ร้านค้า',
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                        ),
                        onPressed: RegisterSeller,
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
