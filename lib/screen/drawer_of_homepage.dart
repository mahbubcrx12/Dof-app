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
      backgroundColor: Colors.white.withOpacity(.8),
      elevation: 5,
      width: MediaQuery.of(context).size.width * .65,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20,bottom: 20),
            child: Text(
              "Menu",
              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 1,
            color: Colors.black54.withOpacity(.3),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),

                InkWell(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => AddFisherMan())));
                  }),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
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
                                //fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black54,
                ),
                InkWell(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => NoticePage())));
                  }),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 7),
                      child: Row(
                        children: [
                          Icon(Icons.add_alert_sharp, color: Colors.black),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Notice",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              //decoration: TextDecoration.none
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black54,
                ),
                InkWell(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => SearchHere())));
                  }),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 7),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.black),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Search",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black54,
                ),
                // Divider(color: Colors.black,height: 2),
                InkWell(
                  onTap: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => IssueSubmitPage())));
                  }),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 7),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.red),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Submit Issue",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Divider(color: Colors.black,height: 2),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).pop();
                //   },
                //   child: Container(
                //     height: 40,
                //     width: 80,
                //     decoration: BoxDecoration(
                //         color: Colors.black26,
                //         borderRadius: BorderRadius.circular(20)),
                //     child: Icon(
                //       Icons.arrow_back,
                //       size: 30,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
