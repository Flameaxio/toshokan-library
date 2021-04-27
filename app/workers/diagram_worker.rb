class DiagramWorker
  include Sidekiq::Worker

  def perform(*args)
    @books_by_genre =  Hash[BookGenreRelationship.all.group(:genre).count.transform_keys(&:name).sort_by { |k, v| -v }[0...10]]
    @books_by_author = Hash[BookAuthorRelationship.all.group(:author).count.transform_keys(&:name).sort_by { |k, v| -v }[0...10]]
    @sales_by_genre = Hash[BookGenreRelationship.select { |item| BookOwnership.all.map(&:book).include?(item.book) }
                                                .group_by(&:genre).transform_keys(&:name).transform_values(&:count)
                                                .sort_by { |k, v| -v }[0...10]]
    @sales_by_author = Hash[BookAuthorRelationship.select { |item| BookOwnership.all.map(&:book).include?(item.book) }
                                                  .group_by(&:author).transform_keys(&:name).transform_values(&:count)
                                                  .sort_by { |k, v| -v }[0...10]]
    Redis.current.set('books_by_genre', @books_by_genre.to_json)
    Redis.current.set('books_by_author', @books_by_author.to_json)
    Redis.current.set('sales_by_genre', @sales_by_genre.to_json)
    Redis.current.set('sales_by_author', @sales_by_author.to_json)
  end
end
