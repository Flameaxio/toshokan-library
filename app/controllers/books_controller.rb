class BooksController < AdminController
  before_action :find_book, only: %i[edit update destroy]
  before_action :prepare_books, only: %i[create update destroy]

  def new
    @book = Book.new
    render 'books/edit'
  end

  def create
    @book = Book.create(book_params)
    create_authors(params[:book][:author_names], @book)
    create_genres(params[:book][:genre_names], @book)
    redirect_to books_path if @book.save
  end

  def edit
    render 'books/edit'
  end

  def update
    @book.update(book_params)
    redirect_to books_path
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:image_url, :name, :description)
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def prepare_books
    @books = Book.order(sales: :desc).paginate(page: params[:page], per_page: 5)
  end

  def create_authors(names, book)
    names.each do |name|
      author = Author.where(name: name).first
      author ||= Author.create(name: name)
      book.authors << author
    end
  end

  def create_genres(names, book)
    names.each do |name|
      genre = Genre.where(name: name).first
      genre ||= Genre.create(name: name)
      book.genres << genre
    end
  end
end
