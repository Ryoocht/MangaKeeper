class MangaKeeper::Manga
    attr_accessor :book_title, :likes, :book_content

    @@all = []

    def initialize(book_title:, likes:, book_content:)
        @book_title = book_title
        @likes = likes
        @book_content = book_content
        # @release_day = book_content[:release_day]
        # @price = book_content[:price]
        @@all << self
    end

    def self.all
        @@all
    end

    def print_manga
        puts "#{book_title}   #{likes}   #{release_day}   #{price}"
    end
end