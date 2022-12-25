import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:motsha_app/const/toast_message.dart';
import 'package:motsha_app/provider/notice_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;


class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  String? noticeFileDownloadingUrl;
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
          .get(noticeFileDownloadingUrl!, options: Options(responseType: ResponseType.bytes));
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
        await dio.download(noticeFileUrl!, dirloc + convertCurrentDateTimeToString()+ ".pdf",// + ".pdf"
            onReceiveProgress: (receivedBytes, totalBytes) {
              //print('here 1');
              setState(() {
                downloading = true;
                progress = ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
                print(progress);
              });
             // print('here 2');
            });
      } catch (e) {
        print('catch catch catch');
        print(e);
      }

      setState(() {
        downloading = false;
        showInToast("Download Successful");
        progress = "Download Completed.";
        path = dirloc + convertCurrentDateTimeToString() + ".pdf";// + ".pdf"
      });
      print(path);
     // print('here give alert-->completed');
    } else {
      setState(() {
        progress = "Permission Denied!";
        _onPressed = () {
          downloadFile(noticeFileUrl: noticeFileDownloadingUrl);
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
                      var noticeFile="${noticeData[index].pdfFile}";
                      var decodedNoticeFile=jsonDecode(noticeFile);
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

                              GridView.builder(
                                shrinkWrap: true,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 0
                                  ),
                                  itemCount: decodedNoticeFile.length,
                                  itemBuilder: (BuildContext context,int index){

                                   // String fileExtension = p.extension(noticeFileDownloadingUrl?.path);
                                    return IconButton(
                                        onPressed: (){
                                          print("${decodedNoticeFile[index].toString()}".split('.'));
                                          noticeFileDownloadingUrl="http://dof-demo.rdtl.xyz/noticeboard/${decodedNoticeFile[index].toString()}";
                                          downloadFile(noticeFileUrl: noticeFileDownloadingUrl);
                                        },
                                        icon: Icon(Icons.picture_as_pdf_rounded,
                                          size: 50,
                                          color: Colors.green,));
                                  }
                              ),

                              // ,SizedBox(height: 10,),
                              //
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   children: [
                              //     InkWell(
                              //       onTap: () async{
                              //
                              //         //     "http://dof-demo.rdtl.xyz/noticeboard/${noticeData[index].image}";
                              //         // _saveImage();
                              //       },
                              //       child: Container(
                              //           height: 30,
                              //           width: 130,
                              //           decoration: BoxDecoration(
                              //             color: Colors.green,
                              //             border: Border(
                              //               left: BorderSide(
                              //                 color: Colors.green,
                              //                 width: 1,
                              //               ),
                              //               right: BorderSide(
                              //                 color: Colors.green,
                              //                 width: 1,
                              //               ),
                              //               top: BorderSide(
                              //                 color: Colors.green,
                              //                 width: 1,
                              //               ),
                              //               bottom: BorderSide(
                              //                 color: Colors.green,
                              //                 width: 1,
                              //               ),
                              //             ),
                              //           ),
                              //           child: Center(
                              //               child: Text("Download Image"))
                              //       ),
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //
                              //       },
                              //       child: Container(
                              //           height: 30,
                              //           width: 130,
                              //           decoration: BoxDecoration(
                              //             color: Colors.green,
                              //             border: Border(
                              //               left: BorderSide(
                              //                 color: Colors.green,
                              //                 width: 1,
                              //               ),
                              //               right: BorderSide(
                              //                 color: Colors.green,
                              //                 width: 1,
                              //               ),
                              //               top: BorderSide(
                              //                 color: Colors.green,
                              //                 width: 1,
                              //               ),
                              //               bottom: BorderSide(
                              //                 color: Colors.green,
                              //                 width: 1,
                              //               ),
                              //             ),
                              //           ),
                              //           child: Center(
                              //               child: Text("Download PDF"))),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(height: 10,)
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
