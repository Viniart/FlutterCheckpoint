import 'package:flutter/material.dart';
import 'package:github_api_demo/api/github_api.dart';
import 'package:github_api_demo/models/organization.dart';
import 'package:github_api_demo/models/repository.dart';
import 'package:github_api_demo/models/subscription.dart';

import '../models/user.dart';

class FollowingPage extends StatefulWidget {
  final User user;
  const FollowingPage({required this.user});

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  final api = GitHubApi();
  late Future<List<User>> _futureFollowings;
  late Future<List<Repository>> _futureRepos;
  late Future<List<Organization>> _futureOrgs;
  late Future<List<Subscription>> _futureSubscriptions;

  @override
  void initState() {
    _futureFollowings = api.getFollowing(widget.user.login);
    _futureRepos = api.getRepos(widget.user.login);
    _futureOrgs = api.getOrgs(widget.user.login);
    _futureSubscriptions = api.getSubscriptions(widget.user.login);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Informações"),
          bottom: const TabBar(tabs: [
            Text('Followers'),
            Text('Repositories'),
            Text('Organizations'),
            Text('Subscriptions'),
          ]),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  NetworkImage(widget.user.avatarUrl),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.user.login,
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: FutureBuilder<List<User>>(
                      future: _futureFollowings,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          var followings = snapshot.data ?? [];
                          return ListView.builder(
                            itemCount: followings.length,
                            itemBuilder: ((context, index) {
                              var user = followings[index];
                              return ListTile(
                                leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user.avatarUrl)),
                                title: Text(user.login),
                                trailing: const Text(
                                  "Following",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              );
                            }),
                          );
                        }
                      },
                    ))
                  ]),
            ),
            // Começo da segunda Aba
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  NetworkImage(widget.user.avatarUrl),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.user.login,
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: FutureBuilder<List<Repository>>(
                      future: _futureRepos,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          var repositories = snapshot.data ?? [];
                          
                          return ListView.builder(
                            itemCount: repositories.length,
                            itemBuilder: ((context, index) {
                              var repo = repositories[index];
                              return ListTile(
                                leading: Icon(Icons.report),
                                title: Text(repo.name),
                                trailing: const Text(
                                  "Repository",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              );
                            }),
                          );
                        }
                      },
                    ))
                  ]),
            ),
            // Terceira Aba
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  NetworkImage(widget.user.avatarUrl),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.user.login,
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: FutureBuilder<List<Organization>>(
                      future: _futureOrgs,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          var organizations = snapshot.data ?? [];
                          if(organizations.isEmpty) {
                            return const Text('User has no organizations');
                          }

                          return ListView.builder(
                            itemCount: organizations.length,
                            itemBuilder: ((context, index) {
                              var org = organizations[index];
                              return ListTile(
                                leading: Icon(Icons.accessible),
                                title: Text(org.name),
                                trailing: const Text(
                                  "Organization",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              );
                            }),
                          );
                        }
                      },
                    ))
                  ]),
            ),
            // Quarta aba
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  NetworkImage(widget.user.avatarUrl),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.user.login,
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: FutureBuilder<List<Subscription>>(
                      future: _futureSubscriptions,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          var subscriptions = snapshot.data ?? [];
                          
                          return ListView.builder(
                            itemCount: subscriptions.length,
                            itemBuilder: ((context, index) {
                              var sub = subscriptions[index];
                              return ListTile(
                                leading: Icon(Icons.accessible),
                                title: Text(sub.name),
                                trailing: Text(
                                  sub.description.length >= 70 ?
                                  sub.description.substring(0, 70) :
                                  sub.description,
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              );
                            }),
                          );
                        }
                      },
                    ))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
