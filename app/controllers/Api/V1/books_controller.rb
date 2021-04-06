module Api
  module V1
    class BooksController < ApiController
      before_action :find_book, only: %i[show destroy]

      def index
        render json: BookSerializer.new(Book.all, { params: { lone: false } }).serialized_json
      end

      def show
        render json: BookSerializer.new(@book, { params: { lone: true } }).serialized_json
      end

      def create
        @author = Author.create(book_params)
        render json: BookSerializer.new(@book).serialized_json
      end

      def destroy
        render json: BookSerializer.new(@book.destroy).serialized_json
      end

      private

      def find_book
        @book = Book.find_by(slug: params[:slug])
      end

      def book_params
        params.require(:book).permit(:name, :slug)
      end
    end
  end
end
