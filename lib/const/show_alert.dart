import 'package:flutter/material.dart';
import '../screen/web_view.dart';

showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        //title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('আপনার রেজিস্ট্রেশন সফলভাবে সম্পন্ন হয়েছে...'),

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('ঠিক আছে',style: TextStyle(color: Colors.green),),
            onPressed: () {
              //Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => MatshoWebPage()));
            },
          ),
        ],
      );
    },
  );
}