require "book_repository"

RSpec.describe BookRepository do
  def reset_books_table
    seed_sql = File.read("spec/seeds_books.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "book_store_test" })
    connection.exec(seed_sql)
  end

  describe BookRepository do
    before(:each) { reset_books_table }

    it "returns a list of books" do
      repo = BookRepository.new
        books = repo.all
        expect(books.length).to eq 2
        expect(books.first.id).to eq ('1')
        expect(books.first.title).to eq ('Ready Player One')
        expect(books.first.author_name).to eq ('Ernest Cline')
    end

    # it "returns a single book" do
    #     repo = BookRepository.new
    #     books = repo.find(1)
    #     expect(books.id).to eq 1
    #     expect(books.title).to eq ('Ready Player One')
    #     expect(books.author_name).to eq ('Ernest Cline')
    # end
  end
end
