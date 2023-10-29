import 'package:avassign/DataList.dart';
import 'package:avassign/blocdata.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dataBloc = DataBloc();

    return MaterialApp(
      home: DefaultTabController(
        length: 3, // Change the number of tabs as needed
        child: Scaffold(
          appBar: AppBar(
            title: const Text('API Data'),
          ),
          body: Column(
            children: [
              Padding(
                padding:  EdgeInsets.all(16.0),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0)),
                  child:  Card(
                    elevation: 4,
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs:  [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Tab(
                            text: 'posts',
                          ),
                        ),
                        Tab(
                          text: 'comments',
                        ),
                        Tab(
                          text: 'other',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    DataList(
                      dataBloc: dataBloc,
                      apiEndpoint: "https://jsonplaceholder.typicode.com/posts",
                    ),
                    DataList(
                      dataBloc: dataBloc,
                      apiEndpoint:
                          "https://jsonplaceholder.typicode.com/comments",
                    ),
                    DataList(
                      dataBloc: dataBloc,
                      apiEndpoint: "https://jsonplaceholder.typicode.com/todos",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
