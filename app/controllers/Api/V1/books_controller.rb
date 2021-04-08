module Api
  module V1
    class BooksController < ApiController
      include CurrentUserConcern
      before_action :find_book, only: %i[show destroy buy check_ownership]

      def index
        books = Book.all
        books = current_user.books if params[:user_id]
        render json: BookSerializer.new(books, { params: { lone: false } }).serialized_json
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

      def buy
        current_user.books << @book
        if current_user.save
          render json: {
            status: 200
          }
        else
          render json: {
            status: 500
          }
        end
      end

      def check_ownership
        if current_user.books.include?(@book)
          render json: {
            status: 200,
            ownership: 'YES'
          }
        else
          render json: {
            status: 200,
            ownership: 'NO'
          }
        end
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
