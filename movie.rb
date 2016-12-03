class Movie

  attr_reader :link, :name, :year, :country, :date_published, :genre, :duration, :rating, :rating_stars, :director, :actors

  def initialize(movie)
    movie.each { |k, v|
      instance_variable_set("@#{k}", v)
    }
    @rating_stars = rating_star_format(@rating)
  end

  def rating_star_format(value)
    rating = value.split('.').first
    "*" * rating.to_i
  end


  def has_genre?(genre)
    genres = self.genre.split(',')
    movies = genres.select { |movie| movie if movie == genre}
    if !movies.empty?
      puts "Film: #{self.name} with genre: #{genre}!"
    else
      puts "Film: #{self.name}, no genre: #{genre} "
    end

  end




end

