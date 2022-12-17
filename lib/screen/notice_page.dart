import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:motsha_app/const/toast_message.dart';
import 'package:motsha_app/provider/notice_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path;

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  String? url;
  String? title;

  @override
  void didChangeDependencies() {
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

  downloadPDF({String? downloadLink, String? title}) async {
    var dio;
    if (await Permission.storage.request().isGranted) {
      final downloadPath = await path.getExternalStorageDirectory();
      var filePath = downloadPath!.path + '/$title';

      dio = Dio();
      await dio.download(downloadLink, filePath).then((value) {
        dio.close();
      }).catchError((Object e) {
        Fluttertoast.showToast(
            msg: "Download successful", timeInSecForIosWeb: 1);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    var noticeData = Provider.of<NoticeProvider>(context).noticeData;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
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
                            children: [
                              Image(
                                image: NetworkImage(
                                    "http://dof-demo.rdtl.xyz/noticeboard/images/${noticeData[index].image}"),
                                fit: BoxFit.cover,
                              ),
                              Text("${noticeData[index].description}"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      url =
                                          "http://dof-demo.rdtl.xyz/noticeboard/images/${noticeData[index].image}";
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
                                          "http://dof-demo.rdtl.xyz/noticeboard/images/${noticeData[index].pdfFile}";
                                      title =
                                          "http://dof-demo.rdtl.xyz/noticeboard/images/${noticeData[index].pdfFileWithExtension}";
                                      downloadPDF(
                                          downloadLink:
                                              "http://dof-demo.rdtl.xyz/noticeboard/images/850fe67f759378fd216837f4ef42ce9b.pdf",
                                          title: title);
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
