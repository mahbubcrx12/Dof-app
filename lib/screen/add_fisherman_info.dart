import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:motsha_app/model/district_model.dart';
import 'package:motsha_app/model/division_list_model.dart';
import 'package:motsha_app/screen/web_view.dart';
import 'package:motsha_app/service/district.dart';
import 'package:motsha_app/service/get_division_list.dart';
import 'package:motsha_app/service/http_service.dart';
import '../const/toast_message.dart';

class AddFisherMan extends StatefulWidget {
  const AddFisherMan({Key? key}) : super(key: key);

  @override
  State<AddFisherMan> createState() => _AddFisherManState();
}

class _AddFisherManState extends State<AddFisherMan> {
  //Declaring controller to take user input text
  TextEditingController fishermanNameBngController = TextEditingController();
  TextEditingController fishermanNameEngController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController mothersNameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController upazillaIdController = TextEditingController();
  TextEditingController postOfficeIdController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  //taking image
  File? image;
  Future takeImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print("Failed to pick image :$e");
    }
  }

  bool onProgress = false;

  //posting data to add
  Future addFisherman() async {
    var link = Uri.parse("http://dof-demo.rdtl.xyz/api/fisher/add-data");
    var request = http.MultipartRequest("POST", link);
    request.headers.addAll(await HttpService.defaultHeader);
    request.fields["fishermanNameBng"] =
        fishermanNameEngController.text.toString();
    request.fields["fishermanNameEng"] =
        fishermanNameBngController.text.toString();
    request.fields["nationalId"] = nationalIdController.text.toString();
    request.fields["mobile"] = mobileController.text.toString();
    request.fields["gender"] = genderController.text;
    request.fields["mothersName"] = mothersNameController.text.toString();
    request.fields["fathersName"] = fathersNameController.text.toString();
    request.fields["divisionId"] = chosenDivision.toString();
    request.fields["districtId"] = chosenDistrict.toString();
    request.fields["upazillaId"] = upazillaIdController.text.toString();
    request.fields["postOfficeId"] = postOfficeIdController.text.toString();
    request.fields["dateOfBirth"] = dateOfBirthController.text.toString();
    var imageFile = await http.MultipartFile.fromPath("image", image!.path);
    request.files.add(imageFile);
    setState(() {
      onProgress = true;
    });
    var response = await request.send();
    var status = response.statusCode;
    print("status cooooooode $status");
    setState(() {
      onProgress = false;
    });
    var responseDataByte = await response.stream.toBytes();
    var responseDataString = String.fromCharCodes(responseDataByte);
    var data = jsonDecode(responseDataString);
    print("status code");
    print(response.statusCode);
    if (response.statusCode == 200) {
      showInToast("${data["message"]}");
      Navigator.of(context).pop();
    } else {
      showInToast("${data["message"]}");
    }

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => MatshoWebPage()));
  }

  //calling division from api
  List<DivisionList> divisionList = [];
  String? chosenDivision;
  getDivision() async {
    divisionList = await GetDivisionList().fetchDivision();
    setState(() {});
  }

  //calling district based on division
  String? chosenDistrict;
  List<DistrictModel> districtList = [];


  //calling division initially
  @override
  void initState() {
    // TODO: implement initState
    getDivision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var divisionList=Provider.of<DivisionProvider>(context).divisionData;
    //var districtList=Provider.of<DistrictProvider>(context).districtData;
    //print("dldldldldldl ${divisionList}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: (() {
            Navigator.of(context).pop();
          }),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Add Fisherman Info",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: fishermanNameBngController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "জেলের নাম",
                        hintText: "জেলের নাম",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: fishermanNameEngController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Fisherman Name",
                        hintText: "Fisherman Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: nationalIdController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "NID Number",
                        hintText: "NID Number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: mobileController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 11 ||
                          value.length > 11) return "Enter a valid number";
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Mobile Number",
                        hintText: "Mobile Number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) return "Field is required";
                      return null;
                    },
                    icon: Icon(Icons.keyboard_arrow_down_sharp),
                    onChanged: (v) {
                      setState(() {
                        genderController.text = v.toString();
                      });
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Gender",
                        hintText: "Gender",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          "Male",
                        ),
                        value: "Male",
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "Female",
                        ),
                        value: "Female",
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: dateOfBirthController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Date Of Birth",
                        hintText: "Date Of Birth",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1930),
                          lastDate: DateTime.now());
                      if (pickedDate != null) {
                        setState(() {
                          dateOfBirthController.text = DateFormat("yyyy-MM-dd")
                              .format(pickedDate)
                              .toString();
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: mothersNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Mother's Name",
                        hintText: "Mother's Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: fathersNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Father's Name",
                        hintText: "Father's Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                  ),
                ),

                // Padding(
                //   padding:
                //   const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                //   child:
                //   DropdownButtonFormField(
                //     value:selectedDivisionName,
                //     isDense: true,
                //     items:divisionList.map((list){
                //       return DropdownMenuItem (
                //         child: Text("${list.divisionEng}"),
                //         value: list.divisionEng,
                //       );
                //     }).toList(),
                //     onChanged: (value){
                //       setState(() {
                //         selectedDivisionName=value.toString();
                //       });
                //       print("ddddddddddd $selectedDivisionName");
                //     },
                //     validator: ( value) {
                //       if(value== null )
                //         return "Field is required";
                //       return null;
                //     },
                //     decoration: InputDecoration(
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.green),
                //         ),
                //         labelText: "Division",
                //         hintText: "Division",
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(12),
                //             gapPadding: 4.0,
                //             borderSide:
                //             BorderSide(color: Color(0xFF642E4C), width: 30))),
                //   ),
                //
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "",
                        hintText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                    value: chosenDivision,
                    hint: Text(
                      'Select Division',
                      overflow: TextOverflow.ellipsis,
                    ),

                    validator: (value) =>
                        value == null ? 'field required' : null,
                    items: divisionList.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(
                              "${item.divisionEng}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            value: item.divisionId.toString(),
                          );
                        }).toList() ??
                        [],
                    onChanged: (String? newValue) {
                      setState(() async{
                        chosenDistrict=null;
                        chosenDivision = newValue;
                        print(
                            "Division id isssssssssssssssssssssssssssssssssssss $chosenDivision");
                        districtList=await GetDistrictList().fetchDistrict(
                            id: int.parse(chosenDivision!));
                        setState(() {

                        });

                      });

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "",
                        hintText: "",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                    value: chosenDistrict,
                    hint: Text(
                      'Select District',
                      overflow: TextOverflow.ellipsis,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        chosenDistrict = newValue;
                        print(
                            "District id isssssssssssssssssssssssssssssssssssss $chosenDivision");
                        GetDistrictList()
                            .fetchDistrict(id: int.parse(chosenDistrict!));
                      });
                    },
                    validator: (value) =>
                    value == null ? 'field required' : null,
                    items: districtList.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(
                          "${item.districtEng}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        value: item.districtId.toString(),
                      );
                    }).toList() ??
                        [],
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: upazillaIdController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Upazilla",
                        hintText: "Upazilla",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: postOfficeIdController,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Post Office",
                        hintText: "Post Office",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide:
                                BorderSide(color: Colors.green, width: 30))),
                  ),
                ),
                InkWell(
                  onTap: () {
                    takeImage();
                  },
                  child: image == null
                      ? Container(
                          height: MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * .5,
                          color: Colors.green.withOpacity(.35),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 80,
                              color: Colors.green,
                            ),
                          ),
                        )
                      : Image.file(
                          File(image!.path),
                          height: 200,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  "Upload an Image",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(13)),
                        child: InkWell(
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              _key.currentState!.save();
                            }
                            if (image == null) {
                              showInToast("Please Upload an Image");
                            }
                            addFisherman();
                          },
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
