import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:motsha_app/screen/drawer_of_homepage.dart';


class MatshoWebPage extends StatefulWidget {
  const MatshoWebPage({Key? key}) : super(key: key);

  @override
  State<MatshoWebPage> createState() => _MatshoWebPageState();
}

class _MatshoWebPageState extends State<MatshoWebPage> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    // TODO: implement initState
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }
  final GlobalKey<ScaffoldState> _drawer=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key:_drawer,
          endDrawer: HomePageDrawer(),
          body: Stack(
      children: [
          WebView(
            initialUrl: "https://app.rdtl.xyz/",
            javascriptMode: JavascriptMode.unrestricted,
          ),
          Positioned(
              right: 0,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  _drawer.currentState?.openEndDrawer();
                 },
                child: Container(
                  height: 40,
                  width: 100,
                  child: Icon(
                    Icons.menu,
                    color: Colors.green,
                    size: 40,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              )),
      ],
    ),
        ));
  }

  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );

}
