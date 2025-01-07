import 'dart:convert';
import 'package:movies/api/api.dart';
import 'package:movies/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/review.dart';
import 'package:movies/models/actor.dart';

class ApiService {
  static Future<List<Movie>?> getTopRatedMovies() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/top_rated?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].skip(6).take(5).forEach(
            (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Movie>?> getCustomMovies(String url) async {
    List<Movie> movies = [];
    try {
      http.Response response =
      await http.get(Uri.parse('${Api.baseUrl}movie/$url'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach(
            (m) => movies.add(
          Movie.fromMap(m),
        ),
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
            (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }

  // Recupera información de un actor según su ID.
  static Future<Actor?> actorById(String id) async {
    Actor actor;
    try {
      // Realiza una solicitud GET a la API para obtener los detalles del actor.
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/$id?api_key=${Api.apiKey}&language=en-US&page=1'));
      // Convierte la respuesta JSON en un objeto Actor.
      actor = Actor.fromJson(response.body);
      return actor;
    } catch (e) {
      return null;
    }
  }

  // Obtiene la lista de películas en las que un actor ha trabajado usando su ID.
  static Future<List<Movie>?> moviesFromActor(String id) async {
    List<Movie> movies = [];
    try {
      // Realiza una solicitud GET a la API para obtener los créditos de películas del actor.
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/$id/movie_credits?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      // Itera sobre los resultados del reparto y crea objetos Movie.
      res['cast'].forEach(
            (m) {
          movies.add(Movie.fromMap(m));
        },
      );
      return movies;
    } catch (e) {
      return null;
    }
  }

  // Busca actores en la API según una consulta proporcionada por parámetro.
  static Future<List<Actor>?> getSearchedActors(String query) async {
    List<Actor> actors = [];
    List<Actor> infoActors = [];
    try {
      // Realiza una solicitud GET a la API para buscar actores por nombre.
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/person?api_key=${Api.apiKey}&language=en-US&query=$query&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      // Convierte los resultados iniciales en objetos Actor.
      res['results'].forEach(
            (m) => actors.add(
          Actor.fromMap(m),
        ),
      );
      // Para cada actor encontrado, obtiene información detallada usando actorById.
      for (var actor in actors) {
        try {
          Actor? infoActor = await actorById(actor.id.toString());
          infoActors.add(infoActor!);
        } catch (e) {
          return null;
        }
      }
      return infoActors;
    } catch (e) {
      return null;
    }
  }

  // Recupera una lista de los 10 actores más populares.
  static Future<List<Actor>?> topTenActors() async {
    List<Actor> actors = [];
    try {
      // Realiza una solicitud GET a la API para obtener los actores populares.
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      // Toma los primeros 10 resultados y los convierte en objetos Actor.
      res['results'].take(10).forEach(
            (a) => actors.add(
          Actor.fromMap(a),
        ),
      );
      // Obtiene información detallada de cada actor utilizando actorById.
      List<Actor> infoActors = [];
      for (var actor in actors) {
        try {
          Actor? infoActor = await actorById(actor.id.toString());
          infoActors.add(infoActor!);
        } catch (e) {
          return null;
        }
      }
      return infoActors;
    } catch (e) {
      return null;
    }
  }

  // Recupera una lista de actores en tendencia (trending) diariamente.
  static Future<List<Actor>?> trendingActors() async {
    List<Actor> actors = [];
    try {
      // Realiza una solicitud GET para obtener actores en tendencia.
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}trending/person/day?api_key=${Api.apiKey}&language=en-US&page=10'));
      var res = jsonDecode(response.body);
      // Salta los primeros 10 resultados y toma los siguientes 9.
      res['results'].skip(10).take(9).forEach(
            (a) => actors.add(
          Actor.fromMap(a),
        ),
      );
      // Para cada actor encontrado, obtiene información detallada usando actorById.
      List<Actor> infoActors = [];
      for (var actor in actors) {
        try {
          Actor? actorInfo = await actorById(actor.id.toString());
          infoActors.add(actorInfo!);
        } catch (e) {
          return null;
        }
      }
      return infoActors;
    } catch (e) {
      return null;
    }
  }

  // Recupera una lista de actores populares (distinta de los top 10).
  static Future<List<Actor>?> popularActors() async {
    List<Actor> actors = [];
    try {
      // Realiza una solicitud GET para obtener actores populares.
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      // Salta los primeros 10 resultados y toma los siguientes 9.
      res['results'].skip(10).take(9).forEach(
            (a) => actors.add(
          Actor.fromMap(a),
        ),
      );
      // Obtiene información detallada de cada actor utilizando actorById.
      List<Actor> infoActors = [];
      for (var actor in actors) {
        try {
          Actor? actorInfo = await actorById(actor.id.toString());
          infoActors.add(actorInfo!);
        } catch (e) {
          return null;
        }
      }
      return infoActors;
    } catch (e) {
      return null;
    }
  }
}
