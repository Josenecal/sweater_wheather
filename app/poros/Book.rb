class Book

  attr_reader :isbn, :title, :publisher

  def initialize(book_hash)
    book_hash[:isbn] ? @isbn = book_hash[:isbn] : @isbn = ["0","0"]
    @title = book_hash[:title]
    book_hash[:publisher] ? @publisher = book_hash[:publisher] : @publisher = ["none"]
  end

end
