require 'awesome_print'
require 'csv'
require 'ostruct'
require 'date'

require './movie'
require './movie_collections'



def lesson_5
  movies = MovieCollection.new('movies.txt')
  puts "method 'all' is: #{movies.all.class}"

  ap movies.sort_by(:year)
  ap movies.stats(:genre)
  ap movies.stats(:actors)
  ap movies.filter(genre: 'Comedy')
  ap movies.filter(year: '1955')
  ap movies.filter(genre: /Crime/)
  ap movies.filter(year: 2000..2005).first(5)

  ap movies.all.first.actors
end


lesson_5