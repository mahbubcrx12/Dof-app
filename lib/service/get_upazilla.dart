import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:motsha_app/model/upazilla_model.dart';


class GetUpazilla {
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
  };

  Future<List<UpazillaModel>> fetchUpazilla({required int divisionID,required int districtID}) async {
    List<UpazillaModel> upazillaListData = [];

    try {
      var link = "http://dof-demo.rdtl.xyz/api/address/get-upazilla/$divisionID/$districtID";
      var response =
      await http.get(Uri.parse(link), headers: await defaultHeader);
       print(response.statusCode);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        UpazillaModel upazillaData;
        for (var i in data) {
          upazillaData = UpazillaModel.fromJson(i);
          upazillaListData.add(upazillaData);


        }

        print("uuuuuuuuuuuuu");
        print(upazillaListData);
        return upazillaListData;
      } else {
        return upazillaListData;
      }
    } catch (e) {
      //print(e);
      return upazillaListData;
    }
  }
}