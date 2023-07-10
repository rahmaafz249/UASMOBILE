import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListQuote extends StatelessWidget {
  final String apiUrl = "https://booking.kai.id/api/stations2";

  const ListQuote({super.key});

  Future<List<dynamic>> _fetchListQuotes() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PT Kereta Api Indonesia'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchListQuotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var listTile = ListTile(
                  leading: Image.asset(
                    'background/Kereta-Api.jpg',
                    width: 60,
                    height: 60,
                  ),
                  title: Text(
                    snapshot.data[index]['code'],
                    textAlign: TextAlign.justify,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama Kereta: " + snapshot.data[index]['name'],
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Stasiun: " + snapshot.data[index]['city'],
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "Kabupaten: " + snapshot.data[index]['cityname'],
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 60,
                    child: Row(
                      children: [
                        Text(snapshot.data[index]['id'].toString()),
                      ],
                    ),
                  ),
                );
                return Card(
                  child: listTile,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
