import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vimigo_technical_interview/constant.dart';

class AttendantResources {
  Future getListAttendants() async {
    var response = await http.get(
      Uri.parse(baseURL + attendantRecordURL),
    );
    return json.decode(response.body);
  }

  Future storeAttendant({required String uri, required Object body}) async {
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: body,
      );
      return json.decode(response.body);
    } catch (e) {
      e.toString();
    }
  }

  Future getSingleAttendant(String attendantId) async {
    var response = await http.get(
      Uri.parse('$baseURL$attendantRecordURL/$attendantId'),
    );
    return json.decode(response.body);
  }

  Future deleteAttendant(String attendantURL) async {
    var response = await http.delete(
      Uri.parse("$baseURL$attendantRecordURL/$attendantURL"),
    );

    return json.decode(response.body);
  }

  Future updateAttendant({required String url, required Object body}) async {
    var response = await http.put(Uri.parse(url), body: body);

    return json.decode(response.body);
  }
}
