import 'package:flutter/material.dart';
import 'package:motsha_app/model/notice.dart';
import '../service/get_all_notice.dart';


class NoticeProvider with ChangeNotifier {
  List<Data> noticeData = [];
  getNoticeData() async {
    noticeData = await GetNoticeData().fetcNotices();
    notifyListeners();
  }
}
