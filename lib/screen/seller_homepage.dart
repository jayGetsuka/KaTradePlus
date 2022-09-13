import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:katradeplus/screen/homepage.dart';
import 'package:katradeplus/screen/showAllproduct.dart';
import 'package:katradeplus/screen/seller_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:katradeplus/screen/seller_order.dart';
import 'package:katradeplus/screen/seller_addProduct.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SellerHome> {
  String storeName = "";
  int idStore = 0;
  int _selectedIndex = 0;
  // ignore: unused_field
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ShowAllProduct(),
    ShowAllOrder(),
    ShowDetail(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _getSession() async {
    storeName = await FlutterSession().get("StoreName");
    idStore = await FlutterSession().get("id");
    if (!mounted) return;
    setState(() {
      storeName = storeName.toString();
      idStore = idStore.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    _getSession();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(storeName),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(                                                                                                                 
                      builder: (context) => const SellerAddProduct()));
            },
          )
        ],
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
