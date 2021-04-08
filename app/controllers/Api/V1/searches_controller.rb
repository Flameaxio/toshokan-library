module Api
  module V1
    class SearchesController < ApiController
      TYPES = %w[Book Author Genre]

      def search
        type = params[:search_type].singularize.capitalize
        unless TYPES.include?(type)
          render json: {
            status: 401
          }
          return
        end
        klass = Object.const_get(type)
        search_result = klass.search("#{params[:query]}", :ranker => :bm25)
        books = []
        if type != 'Book'
          search_result.select! do |item|
            item.slug == params[:value]
          end
          search_result.map do |item|
            BookGenreRelationship.where(genre_id: item.id).map do |relation|
              books << Book.where(id: relation.book_id)&.first
            end
          end
        else
          books = search_result
        end
        render json: BookSerializer.new(books, { params: { lone: false } }).serialized_json
      end
    end
  end
end
