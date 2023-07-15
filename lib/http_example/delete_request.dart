import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteData extends StatefulWidget {
  const DeleteData({super.key});

  @override
  State<DeleteData> createState() => _DeleteDataState();
}

class _DeleteDataState extends State<DeleteData> {
  dynamic responceData = '';
  bool isLoading = false;
  Future<dynamic> deleteData() async {
    setState(() {
      isLoading = true;
    });
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // Request successful, parse the response
      responceData = 'delete data successfully';

      //return jsonData;
    } else {
      // Request failed
      responceData = 'Error: ${response.body}';
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //createPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get request"),
      ),
      body: Center(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          deleteData();
                        },
                        child: Text('submit post')),
                    SizedBox(
                      height: 20,
                    ),
                    Text(responceData)
                  ],
                )),
    );
  }
}
