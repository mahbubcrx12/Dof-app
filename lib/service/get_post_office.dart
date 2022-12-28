import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post_office_model.dart';

class PostOfficeData {
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
  };

  Future<List<PostOfficeModel>> fetchPostOffice({required int divisionID,required int districtID,required int upazillaId}) async {
    List<PostOfficeModel> postOfficeList = [];

    try {
      var link = "http://dof-demo.rdtl.xyz/api/address/get-postoffice/$divisionID/$districtID/$upazillaId";
      var response =
      await http.get(Uri.parse(link), headers: await defaultHeader);
      print("statussssssssssss");
      print(response.statusCode);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        PostOfficeModel postOfficeData;
        for (var i in data) {
          postOfficeData = PostOfficeModel.fromJson(i);
          postOfficeList.add(postOfficeData);
        }

        print("ppppppppppppppppppp");
        print(postOfficeList);
        return postOfficeList;
      } else {
        return postOfficeList;
      }
    } catch (e) {
      print(e);
      return postOfficeList;
    }
  }
}