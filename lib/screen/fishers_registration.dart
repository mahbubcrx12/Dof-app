import 'package:flutter/material.dart';
import 'package:motsha_app/model/district_model.dart';
import 'package:motsha_app/model/division_list_model.dart';
import 'package:motsha_app/service/district.dart';
import 'package:motsha_app/service/get_division_list.dart';
import 'package:provider/provider.dart';

class AddYourSkills extends StatefulWidget {
  static const String id = 'AddYourSkills';

  const AddYourSkills({Key? key}) : super(key: key);

  @override
  _AddYourSkillsState createState() => _AddYourSkillsState();
}

class _AddYourSkillsState extends State<AddYourSkills> {

  String ?chooseDistrict;
  @override
  void initState() {
    // TODO: implement initState
    getSkills();
    super.initState();
  }
  List<DivisionList> divisionListData = [];
  getSkills()async{
    divisionListData=await GetDivisionList().fetchDivision();

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child:Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  decoration: BoxDecoration(

                      border: Border.all(color: Colors.grey, width: 0.2),
                      borderRadius: BorderRadius.circular(10.0)),
                  height: 60,
                  child: Center(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                      decoration: InputDecoration.collapsed(hintText: ''),
                      value: chooseDistrict,
                      hint: Text(
                        'Select Category',
                        overflow: TextOverflow.ellipsis,

                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          chooseDistrict = newValue;
                          print("District id isssssssssssssssssssssssssssssssssssss $chooseDistrict");
                          GetDistrictList().fetchDistrict(id: int.parse(chooseDistrict!));
                          // print();
                        });
                      },
                      validator: (value) =>
                      value == null ? 'field required' : null,
                      items: divisionListData.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(
                            "${item.divisionBng}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          value: item.divisionId.toString(),
                        );
                      }).toList() ??
                          [],
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}