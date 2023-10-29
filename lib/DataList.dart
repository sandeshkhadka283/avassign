import 'package:avassign/DetailsScreen.dart';
import 'package:avassign/blocdata.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:shimmer/shimmer.dart';

class DataList extends StatefulWidget {
  final String apiEndpoint;
  final DataBloc dataBloc;

  DataList({required this.apiEndpoint, required this.dataBloc});

  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  List<dynamic> data = [];
  static String myVideoId = 'PQSagzssvUQ';
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: myVideoId,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );
  bool dataLoaded = false; // Track whether the data is loaded or not

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    final result = await widget.dataBloc.fetchData(widget.apiEndpoint);

    setState(() {
      data = result;
      dataLoaded = true; // Data is now loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: dataLoaded
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable scrolling in the GridView
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              videoId: myVideoId,
                              title: data[0]['title'] ?? "Empty title",
                              description: data[0]['description'] ?? "empty",
                            ),
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  data[index]['title'] ?? "",
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.play_circle_fill,
                                              color: Colors.white),
                                          Text(
                                            "Youtube",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    '1 hour ago',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              YoutubePlayer(
                                controller: _controller,
                                liveUIColor: Colors.amber,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const ShimmerGrid(),
        ),
      ],
    );
  }
}

class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 6, // Number of shimmer items
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.3),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            ),
          );
        },
      ),
    );
  }
}
