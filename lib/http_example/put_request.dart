import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PutRequestExample extends StatefulWidget {
  const PutRequestExample({super.key});

  @override
  State<PutRequestExample> createState() => _PutRequestExampleState();
}

class _PutRequestExampleState extends State<PutRequestExample> {
  dynamic responceData = '';
  bool isLoading = false;
  Future<dynamic> createPut() async {
    setState(() {
      isLoading = true;
    });
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

    final response = await http.put(
      url,
      body: jsonEncode({
        'id': 1,
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      }),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Request successful, parse the response
      responceData = response.body;

      print("our responce is ${response}");
      print(response.statusCode);

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
                          createPut();
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
