module Api
  module V1
    class AuthorsController < ApiController
      before_action :find_author, only: %i[show destroy]

      def index
        render json: AuthorSerializer.new(Author.all).serialized_json
      end

      def show
        render json: AuthorSerializer.new(@author).serialized_json
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
