import 'package:flutter/material.dart';
import 'package:motsha_app/screen/searched_information.dart';

import '../const/toast_message.dart';

class SearchHere extends StatefulWidget {
  const SearchHere({Key? key}) : super(key: key);

  @override
  State<SearchHere> createState() => _SearchHereState();
}

class _SearchHereState extends State<SearchHere> {
  TextEditingController filterController = new TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        leading: IconButton(
            splashRadius: 30,
            splashColor: Colors.blueGrey[200],
            onPressed: (() {
              Future.delayed(const Duration(milliseconds: 60), () {
                Navigator.pop(context);
              });
            }),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black.withOpacity(.6),
            )),
        title: Text(
          "Search Fisher",
          style: TextStyle(color: Colors.black.withOpacity(.65),fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: filterController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Enter Form ID or NID";
                      return null;

                    },
                    decoration: InputDecoration(
                        hintText: "Form ID/NID",
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.green,
                        ),
                        suffixIcon: InkWell(
                          onTap: (){
                            filterController.clear();
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.red,

                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2.0)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.green,
                          width: 20,
                        ))),
                  ),
                ),
                ElevatedButton(

                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(120, 50)),
                        backgroundColor: MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => SearchFisherMan(
                              searchInput: filterController.text,
                            )));
                      }
                    },
                    child: Text("Search",style: TextStyle(
                        fontSize: 20,
                        color: Colors.white.withOpacity(.9) ),)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
