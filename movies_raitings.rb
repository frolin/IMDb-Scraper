movies_list_file = File.open('movies.txt').collect { |line| line.split('|') }


def struct_movies(movies_list)
  movies = []

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
      rating_stars: rating_star_format(movie[7].split('.')[1]),
      director: movie[8],
      stars: movie[9]
    }
    movies << movie
  }
movies
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


movies_struct = struct_movies(movies_list_file)

filtered = filter(movies_struct)

filtered.each { |movie|
  puts "name: #{movie[:name]}"
  puts "Rating: #{movie[:rating]}"
  puts "Rating_stars:#{movie[:rating_stars]}"
  puts ""
}