import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:motsha_app/screen/search_fisherman.dart';
import '../model/fisherman_model.dart';
import 'package:http/http.dart' as http;

class SearchFisherMan extends StatefulWidget {
  SearchFisherMan({Key? key, required this.searchInput}) : super(key: key);
  String searchInput;

  @override
  State<SearchFisherMan> createState() => _SearchFisherManState();
}

class _SearchFisherManState extends State<SearchFisherMan> {
  List<Data> fishermanData = [];

  Future<dynamic> fetchFisherman(searchInput) async {
    try {
      var link =
          "http://dof-demo.rdtl.xyz/api/fisher/get-details/${searchInput}";
      var response = await http.get(Uri.parse(link));

      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        //print("ggggggggggggg $data");

        Data fisharData;
        for (var i in data['data']) {
          fisharData = Data.fromJson(i);
          fishermanData.add(fisharData);
          //print("aaaaaaaaaaaaaaaaaaaaaaaaaa$fishermanData");
        }

        return fishermanData;
      } else {
        return fishermanData;
      }
    } catch (e) {
      print("Errrrrrr $e");
      return fishermanData;
    }
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    await fetchFisherman(widget.searchInput);
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          leading: IconButton(
            splashRadius: 30,
              splashColor: Colors.blueGrey.shade200,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black.withOpacity(.65),
              )),
          centerTitle: true,
          title: Text(
            "Result",
            style: TextStyle(
                color: Colors.black.withOpacity(.65),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(onPressed: (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchHere()));
              },
                  icon: Icon(Icons.search,color: Colors.black.withOpacity(.65),))
            )
          ],
        ),
        body: fishermanData.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: fishermanData.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white.withOpacity(.90),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.blueGrey.withOpacity(.3),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Center(
                                child: Text(
                                  "Personal Information(??????????????????????????? ????????????)",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            //height: MediaQuery.of(context).size.height * .55,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(.1),
                                borderRadius: BorderRadius.circular(0)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image(
                                          image: NetworkImage(
                                            "https://t3.ftcdn.net/jpg/01/65/63/94/360_F_165639425_kRh61s497pV7IOPAjwjme1btB8ICkV0L.jpg",
                                          ),
                                          height: 300,
                                          width: 300,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${fishermanData[index].fishermanNameBng}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${fishermanData[index].fishermanNameEng}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Form ID: ${fishermanData[index].formId}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "NID: ${fishermanData[index].nationalIdNo}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Gender (???????????????): ${fishermanData[index].gender}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Religion (????????????): ${fishermanData[index].religion}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Date of Birth: ${fishermanData[index].dateOfBirth}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Mobile Number (?????????????????? ???????????????): ${fishermanData[index].mobile}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Place Of Birth (???????????????????????????): ${fishermanData[index].placeOfBirth}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Educational Qualifications (???????????????????????? ?????????????????????): ${fishermanData[index].education}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.blueGrey.withOpacity(.3),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Center(
                                child: Text(
                                  "Family Information (??????????????????????????? ????????????) ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.withOpacity(.12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Mother's Name (??????????????? ?????????): ${fishermanData[index].mothersName}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Father's Name (??????????????? ?????????): ${fishermanData[index].fathersName}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Marital Status (????????????????????? ??????????????????): ${fishermanData[index].maritalStaus}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Spouse Name (??????????????????/????????????????????? ?????????): ${fishermanData[index].spouseName}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Total family members (???????????????????????? ????????? ??????????????? ??????????????????): ${fishermanData[index].totalFamilyMember}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Mother's number (?????????????????? ??????????????????): ${fishermanData[index].numberOfMother}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Father's number (??????????????? ??????????????????): ${fishermanData[index].numberOfFather}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Number of spouse (??????????????????/?????????????????? ??????????????????): ${fishermanData[index].numberOfSpouse}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Number of daughters (??????????????? ??????????????????): ${fishermanData[index].numberOfDaughter}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Number of sons (??????????????? ??????????????????): ${fishermanData[index].numberOfSon}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.blueGrey.withOpacity(.3),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Center(
                                child: Text(
                                  "Permanent Address (????????????????????? ??????????????????)",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.blueGrey.withOpacity(.1),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Division (???????????????): ${fishermanData[index].permanentDivision}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "District (????????????): ${fishermanData[index].permanentDistrict}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Upazila (??????????????????): ${fishermanData[index].permanentUpazilla}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Municipality (??????????????????): ${fishermanData[index].permanentMuniciplaity}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Union (?????????????????????): ${fishermanData[index].permanentUnion}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Village (???????????????): ${fishermanData[index].permanentVillage}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Post Office (????????? ??????): ${fishermanData[index].permenentPostOffice}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.blueGrey.withOpacity(.3),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Center(
                                child: Text(
                                  "Present Address (????????????????????? ??????????????????)",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.blueGrey.withOpacity(.1),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Division (???????????????): ${fishermanData[index].presentDistrict}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "District (????????????): ${fishermanData[index].presentDistrict}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Upazilla (??????????????????): ${fishermanData[index].presentUpazilla}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Municipality (??????????????????): ${fishermanData[index].presentMunicipality}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Union (?????????????????????): ${fishermanData[index].presentUnion}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Village (???????????????): ${fishermanData[index].presentVillage}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        left: BorderSide(
                                            color: Colors.black26, width: 1),
                                        right: BorderSide(
                                            color: Colors.black26, width: 1),
                                        top: BorderSide(
                                            color: Colors.black26, width: 1),
                                        bottom: BorderSide(
                                            color: Colors.black26, width: 1),
                                      )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Post Office (????????? ??????): ${fishermanData[index].presentPostOffice}",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Colors.blueGrey.withOpacity(.3),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Center(
                                child: Text(
                                  "Fishing Information (????????? ???????????? ????????????)",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.blueGrey.withOpacity(.1),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Types of fishing (??????????????? ?????????????????? ?????????): ${fishermanData[index].typeOfFishing}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Ownership of the net (??????????????? ????????????????????????): ${fishermanData[index].ownerOfNet}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Length of the net (??????????????? ?????????????????????): ${fishermanData[index].lengthOfNet}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Width of the net (??????????????? ??????????????????): ${fishermanData[index].widthOfNet}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Price of net (??????????????? ???????????????): ${fishermanData[index].priceOfNet}",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Type Of Vessels (????????????????????? ?????????): ${fishermanData[index].typeOfVessel}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Text(
                                        "Owner Of Vessels (????????????????????? ????????????????????????): ${fishermanData[index].ownerOfVessel}",
                                        style: TextStyle(
                                         fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Length Of Vessels (????????????????????? ?????????????????????): ${fishermanData[index].lengthOfVessels}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Length Of Vessels (????????????????????? ?????????????????????): ${fishermanData[index].lengthOfVessels}",
                                          style: TextStyle(
                                           fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Width Of Vessels (????????????????????? ??????????????????): ${fishermanData[index].widthOfVessels}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Height Of Vessels (????????????????????? ??????????????????): ${fishermanData[index].heightOfVessels}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Price Of Vessels (???????????????????????? ???????????????): ${fishermanData[index].priceOfVessels}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Types of employment on the boat (?????????????????? ??????????????????????????????????????? ?????????): ${fishermanData[index].typeOfEmploymentonVessel}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Main Profession (?????????????????? ????????????): ${fishermanData[index].mainProfession}",
                                          style: TextStyle(
                                           fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Sub Profession (?????????????????? ????????????): ${fishermanData[index].subProfession}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Annual Income (????????????????????? ??????): ${fishermanData[index].annualIncome}",
                                          style: TextStyle(
                                           fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Annual savings amount (????????????????????? ???????????????????????? ??????????????????): ${fishermanData[index].fishermenYearlySaving}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Annual loan amount (????????????????????? ???????????? ??????????????????): ${fishermanData[index].fishermenYearlyLoan}",
                                          style: TextStyle(
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(color: Colors.black26,width: 1),
                                            right: BorderSide(color: Colors.black26,width: 1),
                                            top: BorderSide(color: Colors.black26,width: 1),
                                            bottom: BorderSide(color: Colors.black26,width: 1),
                                          )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Livelihood crisis (????????????????????? ??????????????????): ${fishermanData[index].fishermenDangerPeriodofLiving}",
                                          style: TextStyle(
                                           fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Center(
                child: SpinKitThreeBounce(
                  color: Colors.green,
                  size: 60,
                ),
              ));
  }
}
