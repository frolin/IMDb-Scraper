require 'awesome_print'
require 'csv'
require 'ostruct'
require 'date'

require './movie'
require './movie_collections'



def lesson_5
  movies = MovieCollection.new('movies.txt')
  puts "method 'all' is: #{movies.all.class}"

  # ap movies.sort_by(:year).first(5)
  ap movies.filter(:year, '1955')
  ap movies.stats(:director)

  ap movies.all.first.actors
end


lesson_5