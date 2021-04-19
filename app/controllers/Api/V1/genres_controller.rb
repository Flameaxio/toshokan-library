module Api
  module V1
    class GenresController < ApiController
      before_action :find_genre, only: %i[show destroy]

      def index
        @genres = Genre.all.paginate(page: params[:page], per_page: 12)
        render json: GenreSerializer.new(@genres).as_json.merge({page: @genres.current_page, pages: @genres.total_pages})
      end

      def show
        render json: BooksByGenreSerializer.new(@genre, params: params.to_unsafe_h).serialized_json
      end

      def create
        @genre = Genre.create(genre_params)
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
