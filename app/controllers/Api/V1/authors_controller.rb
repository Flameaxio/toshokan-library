module Api
  module V1
    class AuthorsController < ApiController
      before_action :find_author, only: %i[show destroy]

      def index
        @authors = Author.all.paginate(page: params[:page], per_page: 12)
        render json: AuthorSerializer.new(@authors).as_json.merge({page: @authors.current_page, pages: @authors.total_pages})
      end

      def show
        render json: BooksByAuthorSerializer.new(@author, params: params.to_unsafe_h).serialized_json
      end

      def create
        @author = Author.create(author_params)
        render json: AuthorSerializer.new(@author).serialized_json
      end

      def destroy
        render json: AuthorSerializer.new(@author.destroy).serialized_json
      end

      private

      def find_author
        @author = Author.find_by(slug: params[:slug])
      end

      def author_params
        params.require(:author).permit(:name, :slug)
      end
    end
  end
end
