import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../const/toast_message.dart';
import '../service/http_service.dart';

class IssueSubmitPage extends StatefulWidget {
  const IssueSubmitPage({Key? key}) : super(key: key);

  @override
  State<IssueSubmitPage> createState() => _IssueSubmitPageState();
}

class _IssueSubmitPageState extends State<IssueSubmitPage> {
  TextEditingController nameController=TextEditingController();
  TextEditingController mobileNoController=TextEditingController();
  TextEditingController nidController=TextEditingController();
  TextEditingController topicController=TextEditingController();
  TextEditingController messageController=TextEditingController();

  final GlobalKey<FormState> _key=GlobalKey<FormState>();

  bool onProgress = false;

  Future submitIssue() async {

    var link = Uri.parse("http://dof-demo.rdtl.xyz/api/issue-report/submit");
    var request = http.MultipartRequest("POST", link);
    request.headers.addAll(await HttpService.defaultHeader);

    request.fields["name"] = nameController.text.toString();
    request.fields["mobile"] = mobileNoController.text.toString();
    request.fields["nationalId"] = nidController.text.toString();
    request.fields["topic"] = topicController.text.toString();
    request.fields["message"] = messageController.text.toString();

    setState(() {
      onProgress = true;
    });
    var response = await request.send();
    var status = response.statusCode;
    print("ssssssssssssssssss $status");
    setState(() {
      onProgress = false;
    });
    var responseDataByte = await response.stream.toBytes();
    var responseDataString = String.fromCharCodes(responseDataByte);
    var data = jsonDecode(responseDataString);
    if (response.statusCode == 200) {
      showInToast("${data["message"]}");
      Navigator.of(context).pop();
    } else {
      showInToast("${data["message"]}");
    }

    //Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    mobileNoController.dispose();
    nidController.dispose();
    topicController.dispose();
    messageController.dispose();
    super.dispose();
  }

  bool _validate=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text("Submit Your Issue",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Form(
        key: _key,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if(value== null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Fisherman Name",
                        hintText: "Fisherman Name",

                        //errorText: _validate ? 'Value Can\'t Be Empty' : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide:
                            BorderSide(color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: mobileNoController,
                    validator: (value) {
                      if(value== null || value.isEmpty || value.length<11 || value.length>11)
                        return "Enter a valid number";
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Mobile Number",
                        hintText: "Mobile Number",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide:
                            BorderSide(color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: nidController,
                    validator: (value) {
                      if(value== null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "National ID Number",
                        hintText: "National ID Number",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide:
                            BorderSide(color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: topicController,
                    validator: (value) {
                      if(value== null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        labelText: "Topic of Issue",
                        hintText: "Topic of Issue",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide:
                            BorderSide(color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: TextFormField(
                    controller: messageController,
                    maxLines: 10,
                    validator: (value) {
                      if(value== null || value.isEmpty)
                        return "Field is required";
                      return null;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        //labelText: "Message",
                        hintText: "Short and clear description about your issue...",

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4.0,
                            borderSide:
                            BorderSide(color: Color(0xFF642E4C), width: 30))),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                     if(_key.currentState!.validate()){
                       _key.currentState!.save();
                       submitIssue();
                     }


                    },
                    child: Text("Submit Issue"))
              ],),
            ),
          ),
        ),
      ),
    );
  }
}
