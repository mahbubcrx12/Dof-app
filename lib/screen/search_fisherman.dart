import 'package:flutter/material.dart';
import 'package:motsha_app/screen/searched_information.dart';

class SearchHere extends StatefulWidget {
  const SearchHere({Key? key}) : super(key: key);

  @override
  State<SearchHere> createState() => _SearchHereState();
}

class _SearchHereState extends State<SearchHere> {
  TextEditingController filterController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        leading: IconButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Search Fisherman",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: filterController,
                  decoration: InputDecoration(
                      hintText: "Enter Form ID/NID",
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
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => SearchFisherMan(
                              searchInput: filterController.text,
                            )));
                  },
                  child: Text("Search"))
            ],
          ),
        ),
      ),
    );
  }
}
