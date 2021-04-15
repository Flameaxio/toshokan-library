require 'net/http'
require 'csv'

class ImportController < AdminController
  def index
  end

  def create
    filename = params[:file].path
    CSV.foreach(filename, headers: true, liberal_parsing: true, encoding: 'ISO-8859-1') do |row|
      title = row['Title']
      author_name = row['Author']
      author_name = '' if author_name.nil?
      genre_name = row['Genre'].humanize
      genre_name = '' if author_name.nil?
      url = URI.parse('https://baconipsum.com/api/?type=meat-and-filler')
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http|
        http.request(req)
      }
      description = res.body
      image_url = 'https://picsum.photos/400/600'

      author = Author.find_or_create_by(name: author_name)
      genre = Genre.find_or_create_by(name: genre_name)

      book_params = {
        name: title,
        description: description,
        image_url: image_url
      }
      book = Book.create!(book_params)
      book.authors << author
      book.genres << genre
      book.save!
    end
  end
end
