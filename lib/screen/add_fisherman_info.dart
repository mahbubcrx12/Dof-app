import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:motsha_app/model/district_model.dart';
import 'package:motsha_app/model/division_list_model.dart';
import 'package:motsha_app/model/post_office_model.dart';
import 'package:motsha_app/model/upazilla_model.dart';
import 'package:motsha_app/screen/web_view.dart';
import 'package:motsha_app/service/district.dart';
import 'package:motsha_app/service/get_all_notice.dart';
import 'package:motsha_app/service/get_division_list.dart';
import 'package:motsha_app/service/get_post_office.dart';
import 'package:motsha_app/service/get_upazilla.dart';
import '../const/show_alert.dart';
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
      final image = await ImagePicker().pickImage(source: ImageSource.camera,preferredCameraDevice:CameraDevice.front);

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
    request.headers.addAll(await GetNoticeData.defaultHeader);
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
    request.fields["upazillaId"] = chosenUpazilla.toString();
    request.fields["postOfficeId"] = chosenPostOffice.toString();
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
      //showInToast("${data["message"]}");

     // Navigator.of(context).pop();
    } else {
      showInToast("${data["message"]}");
    }
    showAlertDialog(context);

  }

  //calling division from api
  List<DivisionList> divisionList = [];
  String? chosenDivision;

  getDivision() async {
    divisionList = await GetDivisionList().fetchDivision();
    setState(() {});
  }

  //setting district value from api call
  String? chosenDistrict;
  List<DistrictModel> districtList = [];

  //setting upazilla value from api call
  String? chosenUpazilla;
  List<UpazillaModel> upazillaList = [];

  //setting post office value from api call
  String? chosenPostOffice;
  List<PostOfficeModel> postOfficeList = [];

  //calling division initially
  @override
  void initState() {
    // TODO: implement initState
    getDivision();
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          splashColor: Colors.blueGrey[200],
          splashRadius: 30,
          onPressed: (() {
            Future.delayed(const Duration(milliseconds: 60), () {
              Navigator.pop(context);
            });
          }),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black.withOpacity(.65),
          ),
        ),
        title: Text(
          "Fisher Registration",
          style: TextStyle(
              color: Colors.black.withOpacity(.65),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 12, right: 12, bottom: 15),
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
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                        labelText: "Division",
                        hintText: "",
                        border: OutlineInputBorder(
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
                      setState(() async {
                        districtList.clear();
                        upazillaList.clear();
                        postOfficeList.clear();
                        chosenDistrict = null;
                        chosenUpazilla=null;
                        chosenPostOffice=null;

                        chosenDivision = newValue;
                        districtList = await GetDistrictList()
                            .fetchDistrict(id: int.parse(chosenDivision!));

                        setState(() {});
                      });
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                        labelText: "District",
                        hintText: "",
                        border: OutlineInputBorder(
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                    value: chosenDistrict,
                    hint: Text(
                      'Select District',
                      overflow: TextOverflow.ellipsis,
                    ),
                    onChanged: (String? newValue) {

                      setState(() async {
                        upazillaList.clear();
                        postOfficeList.clear();
                        chosenUpazilla=null;
                        chosenPostOffice=null;

                        chosenDistrict = newValue;
                        upazillaList=await GetUpazilla()
                            .fetchUpazilla(
                              divisionID: int.parse(chosenDivision!),districtID: int.parse(chosenDistrict!)
                            );

                        setState(() {});
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Field Required' : null,
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
                        labelText: "Upazilla",
                        hintText: "",
                        border: OutlineInputBorder(
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                    value: chosenUpazilla,
                    hint: Text(
                      'Select Upazilla',
                      overflow: TextOverflow.ellipsis,
                    ),
                    onChanged: (String? newValue) {
                      setState(() async {
                        postOfficeList.clear();
                        chosenPostOffice=null;

                        chosenUpazilla = newValue;
                        postOfficeList= await PostOfficeData()
                            .fetchPostOffice(
                            divisionID: int.parse(chosenDivision!) ,
                            districtID: int.parse(chosenDistrict!),
                            upazillaId: int.parse(chosenUpazilla!) );

                        setState(() {});
                      });

                    },
                    validator: (value) =>
                    value == null ? 'Field Required' : null,
                    items: upazillaList.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(
                          "${item.upazilaEng}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        value: item.upazilaId.toString(),
                      );
                    }).toList() ??
                        [],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                        labelText: "Post Office",
                        hintText: "",
                        border: OutlineInputBorder(
                            gapPadding: 4.0,
                            borderSide: BorderSide(
                                color: Color(0xFF642E4C), width: 30))),
                    value: chosenPostOffice,
                    hint: Text(
                      'Select Post Office',
                      overflow: TextOverflow.ellipsis,
                    ),
                    onChanged: (String? newValue) {
                      setState(() async {
                        chosenPostOffice = newValue;
                        setState(() {});
                      });
                    },
                    validator: (value) =>
                    value == null ? 'Field Required' : null,
                    items: postOfficeList.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(
                          "${item.postOfficeEnglish}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        value: item.postId.toString(),
                      );
                    }).toList() ??
                        [],
                  ),
                ),
                InkWell(
                  onTap: () {
                    takeImage();
                  },
                  child: image == null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .25,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
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
                                  )),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 100,
                                  color: Colors.blueGrey.withOpacity(.5),
                                ),
                                Center(
                                    child: Text(
                                  "Click To Upload Image",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(.65)
                                      //    fontWeight: FontWeight.bold
                                      ),
                                )),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Image.file(
                            File(image!.path),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                          backgroundColor: MaterialStateProperty.all(Colors.green)),
                      onPressed: () {
                        if (image == null) {
                          showInToast("Please Upload an Image");
                        }
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          addFisherman();
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 20, color: Colors.white.withOpacity(.9)),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
