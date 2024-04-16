import 'dart:convert';

import 'package:covid_tracker/Model/world_states_model.dart';

import 'package:covid_tracker/Services/Utils/app_url.dart';
import 'package:http/http.dart' as http;

class StatsServices {
  
  Future<WorldStatsModel> getdatafromapi() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.WorldStatsAPi));

      if (response.statusCode == 200) {
        // Parse JSON response
        var data = jsonDecode(response.body);
        
        // Deserialize JSON into WorldStatsModel object
        return WorldStatsModel.fromJson(data);
      } else {
        // Handle HTTP error status codes
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any other exceptions like network errors, JSON parsing errors, etc.
      throw Exception("Error: $e");
    }
  }

  Future<List<dynamic>> getCountryDataFromApi() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.CountryStatsAPi));

      if (response.statusCode == 200) {
        // Parse JSON response
        var data = jsonDecode(response.body);
        
        // Deserialize JSON into WorldStatsModel object
        return data;
      } else {
        // Handle HTTP error status codes
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any other exceptions like network errors, JSON parsing errors, etc.
      throw Exception("Error: $e");
    }
  }



}
