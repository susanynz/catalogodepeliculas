class Movie {
  final String id;
  final String title;
  final int year;
  final String director;
  final String genre;
  final String synopsis;
  final String imageUrl;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.director,
    required this.genre,
    required this.synopsis,
    required this.imageUrl,
  });
}

final List<Movie> dummyMovies = [
  Movie(
    id: 'm1',
    title: 'The Matrix',
    year: 1999,
    director: 'The Wachowskis',
    genre: 'Ciencia ficción',
    synopsis:
        'Un hacker descubre la verdadera naturaleza de su realidad y su papel en la guerra contra sus controladores.',
    imageUrl:
        'https://m.media-amazon.com/images/I/51EG732BV3L._AC_.jpg',
  ),
  Movie(
    id: 'm2',
    title: 'Inception',
    year: 2010,
    director: 'Christopher Nolan',
    genre: 'Ciencia ficción',
    synopsis:
        'Un ladrón que roba secretos a través de los sueños recibe la misión de implantar una idea en la mente de un objetivo.',
    imageUrl:
        'https://m.media-amazon.com/images/I/51v5ZpFyaFL._AC_.jpg',
  ),
];
