class BooksByAuthorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :slug

  attribute :books do |object, params|
    books = []
    BookAuthorRelationship.where(author_id: object.id).map do |relation|
      books << Book.where(id: relation.book_id)&.first
    end
    ids = books.collect(&:id)
    @books = Book.where(id: ids).paginate(page: params[:page], per_page: 12)
    BookSerializer.new(@books).as_json.merge({page: @books.current_page, pages: @books.total_pages})
  end
end
