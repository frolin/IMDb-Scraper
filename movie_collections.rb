class MovieCollection

  attr_reader :movies, :genres

  CSV_HEADERS = ['link','name', 'year','country', 'date_published','genre', 'duration', 'rating', 'director', 'actors']

  def initialize(file_name)
    @movies = movies_list(CSV_HEADERS, file_name)
  end


  def movies_list(csv_headers, file_name)
    CSV.read(file_name, col_sep: '|', headers: csv_headers).collect { |row|
      Movie.new(row.to_hash, self)
    }
  end

  def all
    @movies.to_a
  end

  def genres
    all.collect {|movie| movie.genre }.flatten
  end




  def sort_by(field)
    begin
      @movies.sort_by(&field)
    rescue
      raise NoMethodError,  "Not found field:#{field}"
    end
  end


  def filter(options)
    options.collect { |field, value|

      @movies.select { |movie|
        if movie.send(field).is_a?(Array)
          movie.send(field).select { |arr| value === arr }.any?
        else
          value === movie.send(field)
        end
      }

    }
  end

  def stats(field)
    @movies.collect { | movie |
      movie.send(field)}.flatten.compact.
        reduce(Hash.new(0)){|h, field| h[field] +=1 ;h}.sort_by(&:last).to_h
  end



end