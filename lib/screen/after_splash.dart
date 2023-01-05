import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkChecking extends StatefulWidget {
  const NetworkChecking({Key? key}) : super(key: key);

  @override
  State<NetworkChecking> createState() => _NetworkCheckingState();
}

class _NetworkCheckingState extends State<NetworkChecking> {
  late StreamSubscription subscription;
  var isDeviceConnected=false;
  bool isAlertSet=false;

  getConnectivity(){
    subscription=Connectivity().onConnectivityChanged.listen((
        ConnectivityResult result) async{
      isDeviceConnected=await InternetConnectionChecker().hasConnection;
      if(!isDeviceConnected && isAlertSet==false){
        showDialogBox();
        setState(() {
          isAlertSet=true;
        });
      }
    }
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    subscription.cancel();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    getConnectivity();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Checking network"),
      ),
    );
  }
  showDialogBox()=>showCupertinoDialog(
      context: context,
      builder: (BuildContext context)=>CupertinoAlertDialog(
        title: const Text("No Internet Connection"),
        content: const Text("Please Check Your Internet Connectivity"),
        actions: <Widget>[
          TextButton(
              onPressed: ()async{
                Navigator.pop(context,'Cancel');
                setState(() {
                  isAlertSet=false;
                });
                isDeviceConnected=await InternetConnectionChecker().hasConnection;
                if(!isDeviceConnected){
                  showDialogBox();
                  setState(() {
                    isAlertSet=true;
                  });
                }
              },
              child: const Text("OK",style: TextStyle(color: Colors.green),))
        ],
      ));

}

