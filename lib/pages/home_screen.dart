import 'package:flutter/material.dart';
import 'package:nontonskuy/constant/style.dart';
import 'package:nontonskuy/pages/movie_screen.dart';
import 'package:nontonskuy/pages/profile_page.dart';
import 'package:nontonskuy/pages/watch_lists_screen.dart';
import 'package:nontonskuy/pages/movie_search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    void onTapIcon(int index) {
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }

    return Scaffold(
      backgroundColor: Style.primaryColor,
      appBar: _currentIndex != 2
          ? AppBar(
              centerTitle: true,
              title: _buildTitle(_currentIndex),
              automaticallyImplyLeading: false, // Tambahkan baris ini
            )
          : null,
      body: PageView(
        controller: _controller,
        children: const <Widget>[
          MovieScreen(),
          MovieSearch(),
          WatchLists(),
          ProfilePage()
        ],
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Style.primaryColor,
        selectedItemColor: Style.purpleColor,
        unselectedItemColor: Style.textColor,
        onTap: onTapIcon,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Movies"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: "Search Movie"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: "Watch Lists"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "About"),
        ],
      ),
    );
  }

  _buildTitle(int _index) {
    switch (_index) {
      case 0:
        return const Text('Movie Shows');
      case 1:
        return const Text('Search Movie');
      case 2:
        return const Text('Watch List');
      case 3:
        return const Text('Profile Page');
      default:
        return null;
    }
  }
}
