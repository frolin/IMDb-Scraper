require 'awesome_print'

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


def movies_filter_if_time(movies_list)
  movies_list.select { |movie| movie if movie[:name].include?("Time") }
end


def movies_by_duration(movies_list)
  puts "Movies by duration last 5:"
  movies_list.sort_by { |movie| movie[:duration].to_i }
end

def comedies_by_date(movies_list)
  puts "Comedies_by_date:"
  movies_list.select { |movie| movie if movie[:genre].include?("Comedy") }.
  sort_by { |movie| movie[:date_published] }
end

def all_movies_directors(movies_list)
  puts "All_movies_directors:"
  movies_list.collect { |movie| movie[:director] }.uniq.
  sort_by { |director| director.split(" ").last }
end

def movies_produced_not_in_usa(movies_list)
  puts "Movies_produced_not_in_usa:"
  movies_list.reject { |movie| movie[:county].include?("USA") }
end


def movies_group_by_directors(movies_list)
  puts "Movies_group_by_directors:"
  movies_list.group_by { |movie| movie[:director] }.sort.
  collect { |director, movies| {director => movies.count} }
end

def actors_in_movies_count(movies_list)
  puts "Actors_in_movies_count:"
  movies_list.collect { |movie| movie[:stars].strip.split(',') }.flatten.sort.
  reduce(Hash.new(0)) { |h, actor| h[actor] += 1; h }
end



def lesson_2(list)
  filtered = movies_filter_if_time(list)
  filtered.each { |movie|
    puts "name: #{movie[:name]}"
    puts "Rating: #{movie[:rating]}"
    puts "Rating_stars:#{movie[:rating_stars]}"
    puts ""
  }
end


def lesson_3(list)
  ap movies_by_duration(list).last(5)
  ap comedies_by_date(list)
  ap all_movies_directors(list)
  ap movies_produced_not_in_usa(list)

  puts "#BONUS"
  ap movies_group_by_directors(list)
  ap actors_in_movies_count(list)
end

movies_struct = struct_movies(movies_list_file)

# lesson_2(movies_struct)
lesson_3(movies_struct)