import 'package:flutter/material.dart';
import 'package:motsha_app/model/district_model.dart';
import 'package:motsha_app/service/district.dart';

class DistrictProvider with ChangeNotifier {
  List<DistrictModel> districtData = [];

  get id => null;
  getDistrictData() async {
    districtData = await GetDistrictList().fetchDistrict(id: id);
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    print(districtData);
    notifyListeners();

  }

}