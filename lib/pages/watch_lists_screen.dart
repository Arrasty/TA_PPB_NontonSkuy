import 'package:flutter/material.dart';
import 'package:nontonskuy/constant/style.dart';
import 'package:nontonskuy/movie_widgets/movie_watch_lists.dart';

class WatchLists extends StatefulWidget {
  const WatchLists({Key? key}) : super(key: key);

  @override
  State<WatchLists> createState() => _WatchListsState();
}

class _WatchListsState extends State<WatchLists> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watch Lists'),
          //centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            indicatorWeight: 5,
            indicatorColor: Style.purpleColor,
            tabs: [
              Text('Movies',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            MovieWatchLists(),
          ],
        ),
      ),
    );
  }
}
