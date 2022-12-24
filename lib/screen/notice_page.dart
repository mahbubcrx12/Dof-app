import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:motsha_app/const/toast_message.dart';
import 'package:motsha_app/model/notice.dart';
import 'package:motsha_app/provider/notice_provider.dart';
import 'package:motsha_app/service/get_all_notice.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  String? url;
  String? title;



  @override
  void didChangeDependencies()async {
    // TODO: implement didChangeDependencies
    Provider.of<NoticeProvider>(context).getNoticeData();


    super.didChangeDependencies();
  }

  //save notice image
  _saveImage() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var response = await Dio()
          .get(url!, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");
      print(result);
      showInToast("Download Successful");
    }
  }

  //downloading pdf from notice
  //final pdfUrl = "http://dof-demo.rdtl.xyz/noticeboard/2022-12-21-09-47-41167161606148.pdf";
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  late Directory externalDir;

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
    DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<void> downloadFile({required String? noticeFileUrl}) async {
    Dio dio = Dio();
    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/dof/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      try {
        FileUtils.mkdir([dirloc]);
        await dio.download(noticeFileUrl!, dirloc + convertCurrentDateTimeToString() + ".pdf",
            onReceiveProgress: (receivedBytes, totalBytes) {
              print('here 1');
              setState(() {
                downloading = true;
                progress = ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
                print(progress);
              });
              print('here 2');
            });
      } catch (e) {
        print('catch catch catch');
        print(e);
      }

      setState(() {
        downloading = false;
        progress = "Download Completed.";
        path = dirloc + convertCurrentDateTimeToString() + ".pdf";
      });
      print(path);
      print('here give alert-->completed');
    } else {
      setState(() {
        progress = "Permission Denied!";
        _onPressed = () {
          downloadFile(noticeFileUrl: url);
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var noticeData = Provider.of<NoticeProvider>(context).noticeData;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          leading: IconButton(
            splashRadius: 30,
              splashColor: Colors.blueGrey[200],
              onPressed: (() {
                Future.delayed(const Duration(milliseconds: 60), () {
                  Navigator.pop(context);
                });
              }),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black87.withOpacity(.8),
              )),
          title: Text(
            "Notice ",
            style: TextStyle(color: Colors.black87.withOpacity(.8)),
          ),
          centerTitle: true,
        ),
        body: noticeData.isNotEmpty
            ? Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: noticeData.length,
                    itemBuilder: (context, index) {
                      var list="${noticeData[index].pdfFile}";
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Card(
                          elevation: 4,
                          color: Colors.white,
                          child: ExpansionTile(
                            title: Text(
                              '${noticeData[index].heading}',
                              style: TextStyle(color: Colors.black),
                              maxLines: 3,
                            ),
                            subtitle: Text(
                              "${noticeData[index].publishingDate}",
                              style: TextStyle(color: Colors.black),
                            ),
                            children:[
                              // Container(
                              //   child: ListView.builder(
                              //   shrinkWrap: true,
                              //   itemCount:"http://dof-demo.rdtl.xyz/noticeboard/${noticeData[index].pdfFile}".length,
                              //   itemBuilder: (context,index){
                              //     return Container(
                              //       height: 100,
                              //       width: 100,
                              //       color: Colors.yellow,
                              //       child: Icon(Icons.ac_unit),
                              //     );
                              //   }),
                              // ),
                              Text("${noticeData[index].pdfFile}"),
                              Text(list),
                             Container(
                               child: ListView.builder(
                                 shrinkWrap: true,
                                   itemCount: list.length,
                                   itemBuilder: (context,index){
                                 return Text(list);
                               }),
                             ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () async{
                                      // await GetNoticeData().fetchNoticeFiles();
                                      url =
                                          "http://dof-demo.rdtl.xyz/noticeboard/${noticeData[index].image}";
                                      _saveImage();
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          border: Border(
                                            left: BorderSide(
                                              color: Colors.green,
                                              width: 1,
                                            ),
                                            right: BorderSide(
                                              color: Colors.green,
                                              width: 1,
                                            ),
                                            top: BorderSide(
                                              color: Colors.green,
                                              width: 1,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.green,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                            child: Text("Download Image"))
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      url =
                                          "http://dof-demo.rdtl.xyz/noticeboard/${noticeData[index].pdfFile}";



                                     // downloadFile(noticeFileUrl: url);
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          border: Border(
                                            left: BorderSide(
                                              color: Colors.green,
                                              width: 1,
                                            ),
                                            right: BorderSide(
                                              color: Colors.green,
                                              width: 1,
                                            ),
                                            top: BorderSide(
                                              color: Colors.green,
                                              width: 1,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.green,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                            child: Text("Download PDF"))),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,)
                            ],
                          ),
                        ),
                      );
                    }))
            : Center(
                child: SpinKitThreeBounce(
                color: Colors.green,
                size: 60,
              )));
  }
}
