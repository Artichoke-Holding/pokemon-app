import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myinfogame/core/consts.dart';
import 'package:myinfogame/core/json_file_parser.dart';
import 'package:myinfogame/models/user.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final Future<List<User>> future;

  @override
  void initState() {
    super.initState();
    future = JsonFileParser<User>.of(context).parse(
      path: AppConsts.dataPath,
      listName: 'users',
      parser: User.fromJson,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Center(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'All people in the world:',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     log('Loading...', name: 'MyInfoGame');
            //
            //     final future = await JsonFileParser<User>.of(context).parse(
            //       path: AppConsts.dataPath,
            //       listName: 'users',
            //       parser: User.fromJson,
            //     );
            //
            //     log(future.length.toString(), name: 'MyInfoGame');
            //   },
            //   child: const Text('Load'),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.9),
                                BlendMode.darken,
                              ),
                              image: NetworkImage(
                                snapshot.data![index].avatar ?? 'NULL',
                              ),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            textColor: Colors.white,
                            tileColor: Colors.black.withOpacity(0.5),
                            onTap: () {
                              log(
                                snapshot.data![index].toString(),
                                name: 'MyInfoGame',
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                snapshot.data![index].avatar ?? 'NULL',
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            title: Row(
                              children: [
                                Text(
                                  snapshot.data![index].name!.first ?? 'NULL',
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  snapshot.data![index].name!.last ?? 'NULL',
                                ),
                                const Gap(8),
                                // Gap(8),
                                // Text(snapshot.data![index].status ?? 'NULL'),
                              ],
                            ),
                            subtitle: Text(
                              snapshot.data![index].job!.title ?? 'NULL',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    // return Text(snapshot.data!.length.toString());
                  }
                  return const Center(child: Text('No data'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
