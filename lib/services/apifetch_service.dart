import 'dart:convert';

import 'package:http/http.dart';

class BooksAPI {
  Future<List> getData() async {
    Response response = await get(Uri.parse(
        "https://projekbooks-default-rtdb.firebaseio.com/semuabuku.json?auth=xOokue1a9zjgrYX3e98Opk2I1Y4oqLePg87E0DC3"));
    Map dataFetchRaw = jsonDecode(response.body);
    List<Map<String, dynamic>> resultList = dataFetchRaw.entries.map((entry) {
      Map<String, dynamic> mapData = Map<String, dynamic>.from(entry.value);
      mapData['id'] = entry.key;
      return mapData;
    }).toList();
    return resultList;
  }

  Future<List> searchData(String query) async {
    Response response = await get(Uri.parse(
        "https://projekbooks-default-rtdb.firebaseio.com/semuabuku.json?auth=xOokue1a9zjgrYX3e98Opk2I1Y4oqLePg87E0DC3"));
    Map dataFetchRaw = jsonDecode(response.body);

    List<Map<String, dynamic>> resultList = dataFetchRaw.entries
        .where((entry) => entry.value['title']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .map((entry) {
      Map<String, dynamic> mapData = Map<String, dynamic>.from(entry.value);
      mapData['id'] = entry.key;
      return mapData;
    }).toList();

    return resultList;
  }
}
