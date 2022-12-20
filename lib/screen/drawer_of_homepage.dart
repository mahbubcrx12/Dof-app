import 'package:flutter/material.dart';
import 'package:motsha_app/screen/add_fisherman_info.dart';
import 'package:motsha_app/screen/issue_submit.dart';
import 'package:motsha_app/screen/notice_page.dart';
import 'package:motsha_app/screen/search_fisherman.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 5,
      width: MediaQuery.of(context).size.width * .65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.green,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.black.withOpacity(.65)),
              ),
            ),
          ),
          // Container(
          //   height: 1,
          //   color: Colors.black54.withOpacity(.3),
          // ),
          Container(

            height: MediaQuery.of(context).size.height * .35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  splashColor: Colors.blueGrey[200],
                  //splashFactory: InkRipple.splashFactory,
                  onTap: (() {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => AddFisherMan()));
                    });
                  }),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.app_registration,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Registration",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87.withOpacity(.80),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black12,
                ),
                InkWell(
                  splashColor: Colors.blueGrey[200],

                  onTap: (() {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => NoticePage()));
                    });
                  }),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Icon(Icons.add_alert_sharp, color: Colors.green),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Notice",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black12,
                ),
                InkWell(
                  splashColor: Colors.blueGrey[200],

                  onTap: (() {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => SearchHere()));
                    });
                  }),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.green),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black12,
                ),
                // Divider(color: Colors.black,height: 2),
                InkWell(
                  splashColor: Colors.blueGrey[200],

                  onTap: (() {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => IssueSubmitPage()));
                    });
                  }),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 7),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.green),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Submit Issue",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
