class Movie

  attr_reader :link, :name, :year, :country, :date_published, :genre, :duration, :rating, :rating_stars, :director, :actors, :month

  def initialize(movie)
    movie.each { |k, v|
      instance_variable_set("@#{k}", v)
    }
    @genre = @genre.split(',')
    @actors = @actors.split(',')
    @rating_stars = rating_star_format(@rating)
  end


  def has_genre?(genre)
     begin
       self.genre.include?(genre)
     rescue
       raise ArgumentError, "not found #{genre}"
     end
  end

  def month
    Date.strptime(self.date_published, '%Y-%m-%d').strftime('%B')
  end

  private

    def rating_star_format(value)
      rating = value.split('.').first
      "*" * rating.to_i
    end


end
