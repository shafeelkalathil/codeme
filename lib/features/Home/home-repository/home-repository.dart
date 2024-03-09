
import 'dart:convert';
import 'package:codemetech/end-points/lead-endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../end-points/api-base-endpoits.dart';
import '../../../model/leads-model.dart';

final homeRepositoryProvider = Provider((ref) => HomeRepository());

class HomeRepository{

  ///getLeads
  Future<List<LeadModel>> getAllLeads(String token) async {
    try {
      var url = Uri.parse(ApiBaseEndPoints.baseUrl + LeadEndPoints.leadBaseUrl);

      var res = await http.get(url, headers: {
        "Authorization":"Token $token"
      });



      if (res.statusCode == 200) {
        var jsonData = json.decode(res.body);
        List<dynamic> leadsJson = jsonData['data']['leads'];
        List<LeadModel> leads = leadsJson.map((e) => LeadModel.fromJson(e)).toList();
        print(leads);
        return leads;

      } else {
        print("Failed to fetch leads: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching leads: $e");
      throw e;
    }
  }


}