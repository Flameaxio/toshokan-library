class DashboardController < AdminController
  attr_accessor :books_by_genre, :books_by_author, :sales_by_genre, :sales_by_author

  def dashboard
    @books_by_genre =  Hash[BookGenreRelationship.all.group(:genre).count.transform_keys(&:name).sort_by { |k, v| -v }[0..10]]
    @books_by_author = Hash[BookAuthorRelationship.all.group(:author).count.transform_keys(&:name).sort_by { |k, v| -v }[0..10]]
    @sales_by_genre = Hash[BookGenreRelationship.select { |item| BookOwnership.all.map(&:book).include?(item.book) }
                                                .group_by(&:genre).transform_keys(&:name).transform_values(&:count)
                                                .sort_by { |k, v| -v }[0..10]]
    @sales_by_author = Hash[BookAuthorRelationship.select { |item| BookOwnership.all.map(&:book).include?(item.book) }
                                                  .group_by(&:author).transform_keys(&:name).transform_values(&:count)
                                                  .sort_by { |k, v| -v }[0..10]]
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
