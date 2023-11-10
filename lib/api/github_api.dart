import 'dart:convert';

import 'package:github_api_demo/models/organization.dart';
import 'package:github_api_demo/models/repository.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class GitHubApi {
  final String baseUrl = 'https://api.github.com/';
  final String token = '';

  Future<User?> findUser(String userName) async {
    final url = '${baseUrl}users/$userName';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var user = User.fromJson(json);

      return user;
    } else {
      return null;
    }
  }

  Future<List<User>> getFollowing(String userName) async {
    final url = '${baseUrl}users/$userName/following';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      var users = jsonList.map<User>((json) => User.fromJson(json)).toList();

      return users ?? [];
    } else {
      return [];
    }
  }

  void getSubscriptions(String userName) async {
    final url = '${baseUrl}users/$userName/subscriptions';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    var jsonList = jsonDecode(response.body);

    print(jsonList);

    // if (response.statusCode == 200) {
    //   var jsonList = jsonDecode(response.body);
    //   var users = jsonList.map<User>((json) => User.fromJson(json)).toList();

    //   return users ?? [];
    // } else {
    //   return [];
    // }
  }

  Future<List<Organization>> getOrgs(String userName) async {
    final url = '${baseUrl}users/$userName/orgs';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      var organizations = jsonList.map<Organization>((json) => Organization.fromJson(json)).toList();

      return organizations ?? [];
    } else {
      return [];
    }
  }

  Future<List<Repository>> getRepos(String userName) async {
    final url = '${baseUrl}users/$userName/repos';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      var repositories = jsonList.map<Repository>((json) => Repository.fromJson(json)).toList();

      return repositories ?? [];
    } else {
      return [];
    }
  }
}
