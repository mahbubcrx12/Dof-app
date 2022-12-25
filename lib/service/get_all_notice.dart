import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:motsha_app/model/notice.dart';

class GetNoticeData {
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
  };

  Future<List<Data>> fetcNotices() async {
    List<Data> noticeData = [];

    try {
      var link = "http://dof-demo.rdtl.xyz/api/noticeboard/get-all-notice";
      var response =
          await http.get(Uri.parse(link), headers: await defaultHeader);
      //print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        Data dataNotice;
        for (var i in data['data']) {
          dataNotice = Data.fromJson(i);
          noticeData.add(dataNotice);

        }

        return noticeData;
      } else {
        return noticeData;
      }
    } catch (e) {
      return noticeData;
    }
  }

  // Future<List<Data>> fetchNoticeFiles() async {
  //   List<Data> noticeFiles = [];
  //   try {
  //     var link = "http://dof-demo.rdtl.xyz/api/noticeboard/get-all-notice";
  //     var response =
  //     await http.get(Uri.parse(link), headers: await defaultHeader);
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       var fetchedData = data['data'][0]['pdfFile'];
  //       print('ppppppppppppppp$fetchedData');
  //       Data dataNotice;
  //       for (var i in data['data']) {
  //         dataNotice = Data.fromJson(i);
  //         noticeFiles.add(dataNotice);
  //       }
  //       return noticeFiles;
  //     } else {
  //       return noticeFiles;
  //     }
  //   } catch (e) {
  //     return noticeFiles;
  //   }
  // }
}
