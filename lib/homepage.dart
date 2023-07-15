import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic newsData;
  Future<dynamic> fetchNews() async {
    final url =
        'https://newsapi.org/v2/everything?q=bitcoin&sortBy=relevancy&pageSize=5&page=1&apiKey=0c025e96fad541dbb99ef3c53104f4c5';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Request successful, parse the response
        final jsonData = jsonDecode(response.body);

        newsData = jsonData;
        print("our responce is ${newsData}");

        //return jsonData;
      } else {
        // Request failed
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Center(
        child: newsData != null
            ? ListView.builder(
                itemCount: newsData['articles'].length,
                itemBuilder: (context, index) {
                  //final article = newsData['articles'][index];
                  // print("Our data is ${article}");
                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 12),
                    height: 150,
                    child: Stack(
                      children: [
                        Text(newsData['articles'][index].title),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(12),
                        //   child: Image.network(
                        //     "${article!.urlToImage}",
                        //     fit: BoxFit.cover,
                        //     width: double.infinity,
                        //   ),
                        // ),
                      ],
                    ),
                  );
                  // return ListTile(
                  //   title: Text(article['title']),
                  //   subtitle: Text(article['description']),
                  // );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
