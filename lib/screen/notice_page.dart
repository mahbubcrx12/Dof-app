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
import 'package:motsha_app/service/get_all_notice.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/notice.dart';


class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  String? noticeFileDownloadingUrl;
  String? title;

  List<Data> noticeData=[];
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    noticeData=await GetNoticeData().fetcNotices();
    setState(() {
    });
    super.didChangeDependencies();
  }

  //save notice image
  _saveImage() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var response = await Dio().get(noticeFileDownloadingUrl!,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");
      print(result);
      showInToast("Download Successful");
    }
  }

  //downloading pdf from notice
  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  var _onPressed;
  late Directory externalDir;
  String? fileExtension;

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
        DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<void> downloadFile(
      {required String? noticeFileUrl, required String? urlPdf}) async {
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
        await dio.download(noticeFileUrl!,
            dirloc + convertCurrentDateTimeToString() + ".${urlPdf}",
            // + ".pdf"
            onReceiveProgress: (receivedBytes, totalBytes) {
          setState(() {
            downloading = true;
            progress =
                ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
            print(progress);
          });
        });
      } catch (e) {
        print('catch catch catch');
        print(e);
      }

      setState(() {
        downloading = false;
        showInToast("Download Completed.");
        progress = "Download Completed.";
        path = dirloc +
            convertCurrentDateTimeToString() +
            ".${urlPdf}"; // + ".pdf"
      });
      print(path);
      // print('here give alert-->completed');
    } else {
      setState(() {
        progress = "Permission Denied!";
        _onPressed = () {
          downloadFile(
              noticeFileUrl: noticeFileDownloadingUrl, urlPdf: fileExtension);
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // var noticeData = Provider.of<NoticeProvider>(context).noticeData;

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
                color: Colors.black.withOpacity(.65),
              )),
          title: Text(
            "Notice ",
            style: TextStyle(color: Colors.black.withOpacity(.65)),
          ),
          centerTitle: true,
        ),
        body: noticeData.isNotEmpty
            ? Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: noticeData.length,
                    itemBuilder: (context, index) {
                      var noticeFile = "${noticeData[index].pdfFile}";
                      var decodedNoticeFile = jsonDecode(noticeFile);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Card(
                          elevation: 4,
                          color: Colors.white,
                          child: ExpansionTile(
                            iconColor: Colors.green,
                            title: Text(
                              '${noticeData[index].heading}',
                              style: TextStyle(color: Colors.black),
                              maxLines: 25,
                            ),
                            subtitle: Text(
                              "${noticeData[index].publishingDate}",
                              style: TextStyle(color: Colors.black),
                            ),
                            children: [
                              GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 0),
                                  itemCount: decodedNoticeFile.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    String s =
                                        "${decodedNoticeFile[index].toString()}";
                                    String s1 = s.substring(s.indexOf(".") + 1);

                                    // String fileExtension = p.extension(noticeFileDownloadingUrl?.path);
                                    return InkWell(
                                        onTap: () {
                                          showInToast("File Downloading...");
                                          fileExtension = s1;
                                          print(fileExtension);
                                          noticeFileDownloadingUrl =
                                              "http://dof-demo.rdtl.xyz/noticeboard/${decodedNoticeFile[index].toString()}";
                                          downloadFile(
                                              noticeFileUrl:
                                                  noticeFileDownloadingUrl,
                                              urlPdf: fileExtension);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(25.0),
                                          child: Image.asset(
                                            s1 == "pdf"
                                              ? "asset/pdf_icon.png"
                                              : s1 == "jpg"
                                                  ? "asset/jpg_icon.png"
                                                  : s1 == "png"
                                                      ? "asset/png_icon.png"
                                                      : s1 == "docx"
                                                          ? "asset/docx_icon.png"
                                                          : s1 == "xlsx"
                                                              ? "asset/xlsx_icon.png"
                                                              : s1 == "csv"
                                                                  ? "asset/csv_icon.png"
                                                                  : s1 == "doc"
                                                                      ? "asset/doc_icon.png"
                                                                      : "asset/default.png",

                                          ),
                                        )
                                    );
                                  }),


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
