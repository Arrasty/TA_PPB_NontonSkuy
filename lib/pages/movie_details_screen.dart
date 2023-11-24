import 'package:flutter/material.dart';
import 'package:nontonskuy/model/hive_movie_model.dart';
import 'package:nontonskuy/model/movie/movie_model.dart';
import 'package:nontonskuy/movie_widgets/movie_info.dart';
import 'package:nontonskuy/movie_widgets/similar_movie_widget.dart';
import 'package:nontonskuy/pages/reviews.dart';
import 'package:nontonskuy/pages/trailers_screen.dart';
import 'package:hive/hive.dart';

class MoviesDetailsScreen extends StatefulWidget {
  const MoviesDetailsScreen({
    Key? key,
    required this.movie,
    this.request,
    this.hiveId,
  }) : super(key: key);
  final Movie movie;
  final String? request;
  final int? hiveId;

  @override
  State<MoviesDetailsScreen> createState() => _MoviesDetailsScreenState();
}

class _MoviesDetailsScreenState extends State<MoviesDetailsScreen> {
  late Box<HiveMovieModel> _movieWatchLists;
  bool isInWatchlist = false;

  @override
  void initState() {
    _movieWatchLists = Hive.box<HiveMovieModel>('movie_lists');
    isInWatchlist = _movieWatchLists.containsKey(widget.movie.id);
    super.initState();
  }

  void _toggleWatchlist() {
    setState(() {
      if (isInWatchlist) {
        _movieWatchLists.delete(widget.movie.id);
      } else {
        HiveMovieModel newValue = HiveMovieModel(
          id: widget.movie.id!,
          rating: widget.movie.rating!,
          title: widget.movie.title!,
          backDrop: widget.movie.backDrop!,
          poster: widget.movie.poster!,
          overview: widget.movie.overview!,
        );
        _movieWatchLists.put(widget.movie.id, newValue);
        _showAlertDialog();
      }
      isInWatchlist = !isInWatchlist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          widget.movie.title!,
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isInWatchlist ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: _toggleWatchlist,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildBackDrop(),
                Positioned(
                  top: 150,
                  left: 30,
                  child: Hero(
                    tag: widget.request == null
                        ? "${widget.movie.id}"
                        : "${widget.movie.id}" + widget.request!,
                    child: _buildPoster(),
                  ),
                ),
              ],
            ),
            MovieInfo(id: widget.movie.id!),
            SimilarMovies(id: widget.movie.id!),
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.redAccent,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => TrailersScreen(
                          shows: "movie",
                          id: widget.movie.id!,
                        ),
                      ));
                    },
                    icon: const Icon(
                      Icons.play_circle_fill_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Watch Trailers',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // New button for "See Reviews" with icon
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blue, // Customize the color as needed
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => Reviews(
                          id: widget.movie.id!,
                          request: "movie",
                        ),
                      ));
                    },
                    icon: const Icon(
                      Icons.rate_review,
                      size: 30,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'See Reviews',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPoster() {
    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
            "https://image.tmdb.org/t/p/w200/" + widget.movie.poster!,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBackDrop() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
            "https://image.tmdb.org/t/p/original/" + widget.movie.backDrop!,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Added to List"),
          content: Text("${widget.movie.title!} successfully added to watch list"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}
