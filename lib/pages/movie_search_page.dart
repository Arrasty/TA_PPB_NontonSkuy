import 'package:flutter/material.dart';
import 'package:nontonskuy/model/movie/movie_model.dart';
import 'package:nontonskuy/model/search_model.dart';
import 'package:nontonskuy/http/http_request.dart';
import 'package:nontonskuy/pages/movie_details_screen.dart';
import 'package:nontonskuy/constant/style.dart';

class MovieSearch extends StatefulWidget {
  const MovieSearch({Key? key}) : super(key: key);

  @override
  _MovieSearchState createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  TextEditingController _searchController = TextEditingController();
  List<Movie> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Search for movies',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Style.deepPurple),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    _performSearch();
                  },
                ),
              ),
              cursorColor: Style.deepPurple,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _searchResults[index].title ?? '',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: _searchResults[index].poster != null
                      ? Image.network(
                          "https://image.tmdb.org/t/p/w200/${_searchResults[index].poster}",
                          width: 50,
                          height: 75,
                        )
                      : Container(),
                  onTap: () {
                    _navigateToMovieDetails(_searchResults[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _performSearch() async {
    final String searchQuery = _searchController.text.trim();
    if (searchQuery.isNotEmpty) {
      try {
        final MovieSearchModel searchResult =
            await HttpRequest.searchMovies(searchQuery);

        setState(() {
          _searchResults = searchResult.results
              .where((movie) =>
                  movie.id != null &&
                  movie.title != null &&
                  movie.overview != null &&
                  movie.title!.isNotEmpty &&
                  movie.id! > 0 &&
                  movie.overview!.isNotEmpty &&
                  movie.poster != null &&
                  movie.poster!.isNotEmpty &&
                  movie.backDrop != null &&
                  movie.backDrop!.isNotEmpty)
              .toList();
        });
      } catch (error) {
        print('Error searching movies: $error');
      }
    }
  }

  void _navigateToMovieDetails(Movie movie) {
    if (movie.id != null && movie.title != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MoviesDetailsScreen(movie: movie),
        ),
      );
    } else {
      print('Incomplete movie details: $movie');
    }
  }
}