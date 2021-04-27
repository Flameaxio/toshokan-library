module Api
  module V1
    class SearchesController < ApiController
      TYPES = %w[Book Author Genre Profile]

      def search
        type = params[:search_type].singularize.capitalize
        unless TYPES.include?(type)
          render json: {
            status: 401
          }
          return
        end
        klass = if type == 'Profile'
                  Object.const_get('Book')
                else
                  Object.const_get(type)
                end
        search_result = klass.search("#{params[:query]}", :ranker => :bm25)
        books = []
        if type != 'Book'
          unless params[:value] == 'profile'
            search_result.select! do |item|
              item.slug == params[:value]
            end
          end
          search_result.map do |item|
            case type
            when 'Genre'
              BookGenreRelationship.where(genre_id: item.id).map do |relation|
                books << Book.where(id: relation.book_id)&.first
              end
            when 'Author'
              BookAuthorRelationship.where(genre_id: item.id).map do |relation|
                books << Book.where(id: relation.book_id)&.first
              end
            when 'Profile'
              BookOwnership.where(book_id: item.id).map do |relation|
                books << Book.where(id: relation.book_id)&.first
              end
            end
          end
        else
          books = search_result
        end
        ids = books.collect(&:id)
        @books = Book.where(id: ids).order('books.created_at ASC').paginate(page: params[:page], per_page: 30)

        render json: BookSerializer.new(@books, { params: { lone: false } }).as_json.merge({ page: @books.current_page, pages: @books.total_pages })
      end
    end
  end
end
