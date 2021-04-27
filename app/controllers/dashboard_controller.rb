class DashboardController < AdminController
  def dashboard
    DiagramWorker.new.perform if Redis.current.get('books_by_genre').nil?
    @books_by_genre = JSON.parse(Redis.current.get('books_by_genre'))
    @books_by_author = JSON.parse(Redis.current.get('books_by_author'))
    @sales_by_genre = JSON.parse(Redis.current.get('sales_by_genre'))
    @sales_by_author = JSON.parse(Redis.current.get('sales_by_author'))
    @books_by_author.transform_keys! do |key|
      key = 'No author' if key == ''
      key
    end
    render 'dashboards/dashboard'
  end

  def books
    @books = Book.order(sales: :desc).paginate(page: params[:page], per_page: 5)

    render 'dashboards/books'
  end

  def search
    ids = Book.search(params[:query]).collect(&:id)
    @books = Book.where(id: ids).paginate(page: params[:page], per_page: 30)

    render 'dashboards/books'
  end
end
