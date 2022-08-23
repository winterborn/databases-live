# (in lib/book_repository.rb)
require_relative "./book"

class BookRepository
    def all
       sql = "SELECT id, title, author_name FROM books;"
        result_set = DatabaseConnection.exec_params(sql, [])

    books = []

    result_set.each do |record|
      book = Book.new
      book.id = record["id"]
      book.title = record["title"]
      book.author_name = record["author_name"]

      books << book
    end

    # puts books.first.author_name
    return books
  end
end