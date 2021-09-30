class MangaKeeper::Manga
    attr_accessor :book_title, :likes, :book_url, :release_day, :price

    @@all = []

    def initialize(book_title:, likes:, book_url:, release_day:, price:)
        @book_title = book_title
        @likes = likes
        @book_url = book_url
        @release_day = release_day
        @price = price
        @@all << self
    end

    def self.all
        @@all
    end

    def print_manga
        puts "#{book_title}   #{likes}   #{release_day}   #{price}"
    end
end