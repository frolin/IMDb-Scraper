class MovieCollection

  attr_reader :movies

  def initialize(file_name)
    @csv_headers = ['link','name', 'year','country', 'date_published','genre', 'duration', 'rating', 'director', 'actors']
    @movies = movies_list(@csv_headers, file_name)
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
    @movies.sort_by(&field) rescue nil
  end


  def filter(field, value)
    @movies.select{ |movie| movie.send(field) == value }
  end

  def stats(field)
    @movies.group_by {|movie| movie.send(field) }.
        reduce({}) { |h, (f,v)| h[f] = v.count; h}.sort_by(&:last).to_h
  end

end