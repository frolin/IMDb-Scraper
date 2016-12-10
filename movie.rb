class Movie
  attr_reader :link, :name, :year, :country, :date_published, :genre, :duration, :rating, :rating_stars, :director, :actors, :date_published_month

  def initialize(movie, collection)
    movie.each { |k, v|
      instance_variable_set("@#{k}", v)
    }
    @year = @year.to_i
    @genre = @genre.split(',')
    @actors = @actors.split(',')
    @rating_stars = rating_star_format(@rating)
    @collection = collection
  end



  def has_genre?(genre)
    raise("This #{genre} not exsists") unless @collection.genres.include?(genre)
    self.genre.include?(genre)
  end

  def date_published_month
    Date.strptime(self.date_published, '%Y-%m-%d').strftime('%B') rescue nil
  end

  private

  def rating_star_format(value)
    rating = value.split('.').first
    "*" * rating.to_i
  end


end
