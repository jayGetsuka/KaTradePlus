// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ShowAllOrder extends StatefulWidget {
  const ShowAllOrder({super.key});

  @override
  State<ShowAllOrder> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ShowAllOrder> {
  int idStore = 0;
  int id = 0;
  _getSession() async {
    idStore = await FlutterSession().get("id");
    if (!mounted) return;
    setState(() {
      id = idStore.toInt();
    });
  }

  var product = [];
  void getProduct() async {
    _getSession();
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

    var collectionName = 'order';
    await db.dropCollection(collectionName);
    var collection = db.collection(collectionName);
    var res =
        await collection.find(mongo.where.eq('seller_id', idStore)).toList();
    if (!mounted) return;
    setState(() {
      product = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    getProduct();
    return Material(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: ListView.builder(
                itemCount: product.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: const Icon(Icons.image),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon:
                                const Icon(Icons.verified, color: Colors.green),
                            tooltip: 'Confirm Order',
                            onPressed: () async {
                              const dbName = 'Katradeplus';
                              const dbAddress = '10.0.2.2';

                              const defaultUri =
                                  'mongodb://$dbAddress:27017/$dbName';
                              var db = mongo.Db(defaultUri);
                              await db.open();

                              Future cleanupDatabase() async {
                                await db.close();
                              }

                              if (!db.masterConnection.serverCapabilities
                                  .supportsOpMsg) {
                                return;
                              }

                              var collectionName = 'order';
                              await db.dropCollection(collectionName);
                              var collection = db.collection(collectionName);
                              var res = await collection
                                  .deleteOne(<String, Object>{
                                '_id': product[index]['_id']
                              },
                                      collation: mongo.CollationOptions('fr',
                                          strength: 1));
                              // ignore: use_build_context_synchronously
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_forever_rounded,
                                color: Colors.red),
                            tooltip: 'Delete Order',
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('ต้องการปฏิเสธคำสั่งหรือไม่',
                                    style: TextStyle(color: Colors.black)),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context,
                                          "ยกเลิก"); // ignore: use_build_context_synchronously
                                    },
                                    child: const Text('ยกเลิก'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context, "ตกลง");
                                      const dbName = 'Katradeplus';
                                      const dbAddress = '10.0.2.2';

                                      const defaultUri =
                                          'mongodb://$dbAddress:27017/$dbName';
                                      var db = mongo.Db(defaultUri);
                                      await db.open();

                                      Future cleanupDatabase() async {
                                        await db.close();
                                      }

                                      if (!db.masterConnection
                                          .serverCapabilities.supportsOpMsg) {
                                        return;
                                      }

                                      var collectionName = 'order';
                                      await db.dropCollection(collectionName);
                                      var collection =
                                          db.collection(collectionName);
                                      var res = await collection
                                          .deleteOne(<String, Object>{
                                        '_id': product[index]['_id']
                                      },
                                              collation: mongo.CollationOptions(
                                                  'fr',
                                                  strength: 1));
                                      // ignore: use_build_context_synchronously
                                    },
                                    child: const Text('ตกลง'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text((product[index]['p_name']).toString()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            // ignore: prefer_interpolation_to_compose_strings
                            child: Text("จำนวน: " +
                                (product[index]['p_count']).toString()),
                          ),
                          // ignore: prefer_interpolation_to_compose_strings
                          Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              (product[index]['total_price']).toString() + "฿"),
                        ],
                      ));
                })));
  }
}
