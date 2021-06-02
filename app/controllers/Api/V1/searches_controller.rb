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
        books = []
        if klass.to_s != 'Book'
          search_result = Book.search(params[:query].to_s).select do |item|
            item.send("#{klass.to_s.downcase}s").include?(klass.find_by(slug: params[:value]))
          end
          ids = search_result.collect(&:id)
        else
          search_result = Book.search(params[:query].to_s)
          if type == 'Profile'
            search_result.map do |item|
              BookOwnership.where(book_id: item.id).map do |relation|
                books << Book.where(id: relation.book_id)&.first
              end
            end
            ids = books.collect(&:id)
          else
            ids = search_result.collect(&:id)
          end
        end
        @books = Book.where(id: ids).order('books.created_at ASC').paginate(page: params[:page], per_page: 30)

        render json: BookSerializer.new(@books, { params: { lone: false } }).as_json.merge({ page: @books.current_page, pages: @books.total_pages })
      end
    end
  end
end
