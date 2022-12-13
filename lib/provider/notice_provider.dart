import 'package:flutter/material.dart';
import 'package:motsha_app/model/notice.dart';

import 'package:motsha_app/service/http_service.dart';

class NoticeProvider with ChangeNotifier {
  List<Data> noticeData = [];
  getNoticeData() async {
    noticeData = await HttpService().fetcNotices();
    notifyListeners();
  }
}
