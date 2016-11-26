require 'awesome_print'
require 'csv'
require 'ostruct'
require 'date'

def rating_star_format(value)
  rating = value.split('.').first
  "*" * rating.to_i
end


movies_list_file = CSV.read('movies.txt', col_sep: '|', headers: true)

movies_list_struct = movies_list_file.collect { |row|
  movies_struct = OpenStruct.new(row.to_hash)
  movies_struct[:rating_stars] = rating_star_format(movies_struct.rating)

  movies_struct
}


def movies_filter_if_time(movies_list)
  movies_list.select { |movie| movie.name.include?("Time") }
end


def movies_by_duration(movies_list)
  puts "Movies by duration last 5:"
  movies_list.sort_by { |movie| movie.duration.to_i }
end

def comedies_by_date(movies_list)
  puts "Comedies_by_date:"
  movies_list.select { |movie| movie if movie.genre.include?("Comedy") }.
      sort_by { |movie| movie.date_published }
end

def all_movies_directors(movies_list)
  puts "All_movies_directors:"
  movies_list.collect { |movie| movie.director }.uniq.
      sort_by { |director| director.split(" ").last }
end

def movies_produced_not_in_usa(movies_list)
  puts "Movies_produced_not_in_usa:"
  movies_list.reject { |movie| movie.county.include?("USA") }
end


def movies_group_by_directors(movies_list)
  puts "Movies_group_by_directors:"
  movies_list.group_by { |movie| movie.director }.sort.
      collect { |director, movies| {director => movies.count} }
end

def actors_in_movies_count(movies_list)
  puts "Actors_in_movies_count:"
  movies_list.collect { |movie| movie.stars.strip.split(',') }.flatten.sort.
      reduce(Hash.new(0)) { |h, actor| h[actor] += 1; h }
end

def by_month(movies_list)
  movies_list.collect { |movies|
    begin
      Date.strptime(movies.date_published, '%Y-%m-%d')
    rescue
      # try to catch not full format of date
      if movies.date_published.split('-').size == 2
        Date.strptime(movies.date_published, '%Y-%m')
      else
        puts "Movie without month only year; #{movies.name} -  #{movies.date_published}}"
        Date.strptime(movies.date_published, '%Y')
      end
    end
  }.group_by { |d| d.strftime('%B') }.
      reduce({}) { |h, (month,movies)| h[month] = movies.count; h }
end




def lesson_2(list)
  filtered = movies_filter_if_time(list)
  puts "Filtered with 'Time':"
  puts "------"
  filtered.each { |movie|
    puts "name: #{movie.name}"
    puts "Rating: #{movie.rating}"
    puts "Rating_stars:#{movie.rating_stars}"
    puts "------"
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


def lesson_4(movies_struct)
  ap by_month(movies_struct)
end

# lesson_2(movies_list_struct)
# lesson_3(movies_list_struct)
lesson_4(movies_list_struct)