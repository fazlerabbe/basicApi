import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostRequestExample extends StatefulWidget {
  const PostRequestExample({super.key});

  @override
  State<PostRequestExample> createState() => _PostRequestExampleState();
}

class _PostRequestExampleState extends State<PostRequestExample> {
  dynamic responceData = '';
  bool isLoading = false;
  Future<dynamic> createPost() async {
    setState(() {
      isLoading = true;
    });
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    final response = await http.post(
      url,
      body: jsonEncode({
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
                          createPost();
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
