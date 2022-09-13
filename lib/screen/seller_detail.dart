// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ShowDetail extends StatefulWidget {
  const ShowDetail({super.key});

  @override
  State<ShowDetail> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ShowDetail> {
  int idStore = 0;
  String storeName = "";
  String storeAddr = "";
  String storeEmail = "";
  _getSession() async {
    idStore = await FlutterSession().get("id");
    storeName = await FlutterSession().get("StoreName");
    storeAddr = await FlutterSession().get("StoreAddr");
    storeEmail = await FlutterSession().get("StoreEmail");
    if (!mounted) return;
    setState(() {
      idStore = idStore.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    _getSession();
    return Material(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('market2.png'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("ชื่อร้าน:  $storeName",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("ที่อยู่ร้านค้า:  $storeAddr",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("อีเมล:  $storeEmail",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )));
  }
}
