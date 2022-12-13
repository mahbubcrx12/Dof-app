import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:motsha_app/screen/add_fisherman_info.dart';
import 'package:motsha_app/screen/issue_submit.dart';
import 'package:motsha_app/screen/notice_page.dart';
import 'package:motsha_app/screen/search_fisherman.dart';
import 'package:motsha_app/screen/searched_information.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MatshoWebPage extends StatefulWidget {
  const MatshoWebPage({Key? key}) : super(key: key);

  @override
  State<MatshoWebPage> createState() => _MatshoWebPageState();
}

class _MatshoWebPageState extends State<MatshoWebPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("select an option"),
                        content: Container(
                          height: MediaQuery.of(context).size.height*.35,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) => AddFisherMan())));
                                }),
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.teal.withOpacity(.8)),
                                  child: Center(
                                    child: Text(
                                      "Registration",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.yellowAccent,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) => NoticePage())));
                                }),
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(.8)),
                                  child: Center(
                                    child: Text(
                                      "Notice",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                      SearchHere())));
                                }),
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.8)),
                                  child: Center(
                                    child: Text(
                                      "Search",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) => IssueSubmitPage())));
                                }),
                                child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey),
                                  child: Center(
                                    child: Text(
                                      "Submit Issues",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
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
    ));
  }
}
