require 'awesome_print'

require 'date'

movies_list_file = File.open('movies.txt').collect { |line| line.split('|') }


def struct_movies(movies_list)
  movies_list.collect { |movie|
    {
      link: movie[0],
      name: movie[1],
      year: movie[2],
      county: movie[3],
      date_published: movie[4],
      genre: movie[5],
      duration: movie[6],
      rating: movie[7],
      rating_stars: rating_star_format(movie[7].split('.').last),
      director: movie[8],
      stars: movie[9]
    }
  }
end


def rating_star_format(value)
   "*" * value.to_i
end


def filter(movies_list)
  filters = {time: 'Time'}
  filtered = []

  movies_list.each { |movie|
    if movie[:name].include?(filters[:time])
      filtered << movie
    end
  }
filtered
end


def fifth_movie_max_length(movies_list)
   movies_list.sort_by { |movie|
      movie[:duration].to_i
    }
end

def comedy_sort_by_date(movies_list)
  movies_list.sort_by { |movie|
    if movie[:genre].include?("Comedy")
       movie[:year].to_i
    end
    }
end

def order_by_directors_uniq(movies_list)

end

def movie_captured_not_from_usa(movies_list)

end


movies_struct = struct_movies(movies_list_file)
fifth_movie_max_length(movies_struct).last(5)
comedy_sort_by_date(movies_struct)
# filtered = filter(movies_struct)

# filtered.each { |movie|
#   puts "name: #{movie[:name]}"
#   puts "Rating: #{movie[:rating]}"
#   puts "Rating_stars:#{movie[:rating_stars]}"
#   puts ""
# }