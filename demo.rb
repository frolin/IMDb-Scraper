require 'awesome_print'
require 'csv'
require 'ostruct'
require 'date'

require './movie_collections'
require './movie'






def lesson_5
  movies = MovieCollection.new('movies.txt')
  puts "method 'all' is: #{movies.all.class}"

  puts "stats:"
  stats(movies)

  puts "sortting:"
  sorting(movies)

  puts "filtered"
  filtered(movies)

  puts "has_genres"
  has_genres(movies)
end

def stats(movies)
  ap movies.stats(:genre)
  ap movies.stats(:actors)
  ap movies.stats(:date_published_month)
  ap movies.stats(:director)
end

def sorting(movies)
  ap movies.sort_by(:year).first(5)
  ap movies.sort_by(:genre).first(5)
end


def filtered(movies)
  movies.filter(genre: 'Crime').first(5)
  ap movies.filter(genre: /My/).first(5)
  ap movies.filter(year: 1992..2000).first(5)
end


def has_genres(movies)
  begin
    movies.all.first.has_genre?('Crime')
    movies.all.first.has_genre?('Action')
    movies.all.first.has_genre?('SM')
  rescue => e
    puts e.message
  end

end


lesson_5