import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:permission_handler/permission_handler.dart';
import 'package:katradeplus/screen/seller_order.dart';
import 'package:katradeplus/screen/seller_addProduct.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:katradeplus/screen/homepage.dart';
import 'package:katradeplus/screen/showAllproduct.dart';
import 'package:katradeplus/screen/seller_detail.dart';

/// Define App ID and Token
const APP_ID = '0f0ed9be832e4f1bbfbe2df4b7bcb412';
const Token =
    '007eJxTYPj0U8RBbLLE16iMaA25na//NzYsbj9nd/JYvhLbhkpe8+8KDAZpBqkplkmpFsZGqSZphklJaUmpRilpJknmSclJJoZGLAK2yU2JdsnyARmMTAyMYAjiczNkJ5YUJaakFuSUFjMwsDKAAAA1jiMa';

class LiveStream extends StatefulWidget {
  @override
  Live createState() => Live();
}

// App state class
class Live extends State<LiveStream> {
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

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
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Init the app
  Future<void> initPlatformState() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }

    // Create RTC client instance
    RtcEngineContext context = RtcEngineContext(APP_ID);
    var engine = await RtcEngine.createWithContext(context);
    // Define event handling logic
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('joinChannelSuccess ${channel} ${uid}');
      setState(() {
        _joined = true;
      });
    }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = 0;
      });
    }));
    // Enable video
    await engine.enableVideo();
    // Set channel profile as livestreaming
    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    // Set user role as broadcaster
    await engine.setClientRole(ClientRole.Broadcaster);
    await engine.joinChannel(Token, 'katradeplus', null, 0);
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    _getSession();
    return MaterialApp(
      home: Scaffold(
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                ),
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'LIVE',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: [
            Center(child: _renderLocalPreview()),
          ],
        ),
      ),
    );
  }

  // Local video rendering
  Widget _renderLocalPreview() {
    if (_joined && defaultTargetPlatform == TargetPlatform.android ||
        _joined && defaultTargetPlatform == TargetPlatform.iOS) {
      return RtcLocalView.SurfaceView();
    }

    if (_joined && defaultTargetPlatform == TargetPlatform.windows ||
        _joined && defaultTargetPlatform == TargetPlatform.macOS) {
      return RtcLocalView.TextureView();
    } else {
      return Text(
        'Joining Channel',
        textAlign: TextAlign.center,
      );
    }
  }

  // Remote video rendering
  Widget _renderRemoteVideo() {
    if (_remoteUid != 0 && defaultTargetPlatform == TargetPlatform.android ||
        _remoteUid != 0 && defaultTargetPlatform == TargetPlatform.iOS) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
        channelId: "katradeplus",
      );
    }

    if (_remoteUid != 0 && defaultTargetPlatform == TargetPlatform.windows ||
        _remoteUid != 0 && defaultTargetPlatform == TargetPlatform.macOS) {
      return RtcRemoteView.TextureView(
        uid: _remoteUid,
        channelId: "katradeplus",
      );
    } else {
      return Text(
        'Please wait remote user join',
        textAlign: TextAlign.center,
      );
    }
  }
}
