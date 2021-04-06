module Api
  module V1
    class GenresController < ApiController
      before_action :find_genre, only: %i[show destroy]

      def index
        render json: GenreSerializer.new(Genre.all).serialized_json
      end

      def show
        render json: BooksByGenreSerializer.new(@genre).serialized_json
      end

      def create
        @author = Author.create(genre_params)
        render json: GenreSerializer.new(@genre).serialized_json
      end

      def destroy
        render json: GenreSerializer.new(@genre.destroy).serialized_json
      end

      private

      def find_genre
        @genre = Genre.find_by(slug: params[:slug])
      end

      def genre_params
        params.require(:genre).permit(:name, :slug)
      end
    end
  end
end
