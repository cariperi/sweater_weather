class LibraryService
  def get_books(keyword, limit)
    get_url("/search.json?q=#{keyword}&limit=#{limit}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://openlibrary.org') do |f|
    end
  end
end
