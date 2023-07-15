import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetRequestExample extends StatefulWidget {
  const GetRequestExample({super.key});

  @override
  State<GetRequestExample> createState() => _GetRequestExampleState();
}

class _GetRequestExampleState extends State<GetRequestExample> {
  dynamic responceData = '';
  bool isLoading = true;
  List<dynamic> postList = [];
  Future<dynamic> fetchData() async {
    // setState(() {
    //   isLoading = true;
    // });
    final url = 'https://jsonplaceholder.typicode.com/posts';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Request successful, parse the response
        postList = jsonDecode(response.body);

        responceData = postList.toString();
        print("our responce is ${responceData}");
        print(response.statusCode);

        //return jsonData;
      } else {
        // Request failed
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred
      throw Exception('Error: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get request"),
      ),
      body: Center(
          child: postList != null
              ? ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(postList[index]['id'].toString()),
                      trailing: Text(postList[index]['title']),
                    );
                  },
                )
              : Center(child: CircularProgressIndicator())),
    );
  }
}
