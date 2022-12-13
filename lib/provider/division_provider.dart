import 'package:flutter/material.dart';
import 'package:motsha_app/model/division_list_model.dart';
import 'package:motsha_app/service/get_division_list.dart';

class DivisionProvider with ChangeNotifier {
  List<DivisionList> divisionData = [];
  getDivisionData() async {
    divisionData = await GetDivisionList().fetchDivision();
    notifyListeners();

  }

}