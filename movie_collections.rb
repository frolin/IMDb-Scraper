class MovieCollection

  attr_reader :movies

  CSV_HEADERS = ['link','name', 'year','country', 'date_published','genre', 'duration', 'rating', 'director', 'actors']

  def initialize(file_name)
    @movies = movies_list(CSV_HEADERS, file_name)
  end


  def movies_list(csv_headers, file_name)
    CSV.read(file_name, col_sep: '|', headers: csv_headers).collect { |row|
      Movie.new(row.to_hash)
    }
  end

  def all
    @movies.to_a
  end

  def sort_by(field)
    begin
      @movies.sort_by(&field)
    rescue
      raise NoMethodError,  "Not found field:#{field}"
    end
  end


  def filter(options = {})
    options.collect { |field, value|
      case value
        when Regexp
          @movies.select { |movie|
            if movie.send(field).to_s.match(value)
              movie
            end
          }
        when Range
          @movies.select { |movie|
            movie if value.include?(movie.send(field).to_i)
          }
        when String
          @movies.select { |movie|
            if movie.send(field) == value || movie.send(field).include?(value)
              movie
            end
          }
      end.sort_by(&field)
    }
  end

  def stats(field)
    case field
      when :director
        @movies.group_by {|movie| movie.send(field) }.
            reduce({}) { |h, (f,v)| h[f] = v.count; h}

      when :actors, :genre
        @movies.collect {|movie| movie.send(field) }.flatten.
            inject(Hash.new(0)){|h,arr| h[arr] +=1 ;h}

      when :month
        @movies.collect {|movie| movie.send(:month) }.compact.
            reduce(Hash.new(0)) { |h, (f,v)| h[f] +=1; h}

      else
        @movies.group_by {|movie| movie.send(field) }.
            reduce({}) { |h, (f,v)| h[f] = v.count; h}

    end.sort_by(&:last).to_h

  end

end