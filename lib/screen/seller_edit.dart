// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:katradeplus/screen/seller_login.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:katradeplus/screen/seller_homepage.dart';

class SellerEditProduct extends StatefulWidget {
  const SellerEditProduct({super.key});

  @override
  State<SellerEditProduct> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SellerEditProduct> {
  @override
  Widget build(BuildContext context) {
    var idStore = 0;
    var idProd = 0;
    _getSession() async {
      idStore = await FlutterSession().get("id");
      idProd = await FlutterSession().get("idProduct_for_edit");
    }

    _getSession();

    TextEditingController productName = TextEditingController();
    TextEditingController productDetail = TextEditingController();
    TextEditingController productPrice = TextEditingController();
    TextEditingController productType = TextEditingController();
    TextEditingController productCount = TextEditingController();
    // ignore: non_constant_identifier_names
    void SellerLoadDataFromID() async {
      const dbName = 'Katradeplus';
      const dbAddress = '10.0.2.2';
      const defaultUri = 'mongodb://$dbAddress:27017/$dbName';

      var db = mongo.Db(defaultUri);
      await db.open();

      // ignore: unused_element
      Future cleanupDatabase() async {
        await db.close();
      }

      if (!db.masterConnection.serverCapabilities.supportsOpMsg) {
        return;
      }

      var collectionName = 'product';
      await db.dropCollection(collectionName);
      var collection = db.collection(collectionName);
      var res = await collection.find(mongo.where.eq('_id', idProd)).toList();
      if (!mounted) return;

      productName.text = res.first['p_name'];
      productDetail.text = res.first['p_detail'];
      productPrice.text = res.first['price'].toString();
      productCount.text = res.first['amount'].toString();
      productType.text = res.first['p_type'];
      idStore = idStore.toInt();
    }

    // ignore: non_constant_identifier_names
    void SellerAddproduct() async {
      const dbName = 'Katradeplus';
      const dbAddress = '10.0.2.2';
      const defaultUri = 'mongodb://$dbAddress:27017/$dbName';

      var db = mongo.Db(defaultUri);
      await db.open();

      // ignore: unused_element
      Future cleanupDatabase() async {
        await db.close();
      }

      if (!db.masterConnection.serverCapabilities.supportsOpMsg) {
        return;
      }

      var collectionName = 'product';
      await db.dropCollection(collectionName);
      var collection = db.collection(collectionName);
      var res = await collection
          .replaceOne(mongo.where.eq('_id', idProd), <String, Object>{
        '_id': idProd,
        'p_name': productName.text,
        'price': productPrice.text,
        'amount': productCount.text,
        'p_detail': productDetail.text,
        'p_type': productType.text,
        'seller_id': idStore
      });

      if (!res.isSuccess) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              // Retrieve the text the that user has entered by using the
              // TextEditingController.
              content: Text('Error detected in record Update'),
            );
          },
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SellerHome()));
      }
      await cleanupDatabase();
    }

    SellerLoadDataFromID();
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
                        "เพิ่มสินค้า",
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
                        controller: productName,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'ชื่อสินค้า',
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
                        controller: productDetail,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'รายละเอียด',
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
                        controller: productPrice,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'ราคา',
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
                        controller: productType,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'ประเภท',
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
                        controller: productCount,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        decoration: const InputDecoration(
                          labelText: 'จำนวน',
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
                        onPressed: SellerAddproduct,
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'แก้ไขสินค้า',
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
