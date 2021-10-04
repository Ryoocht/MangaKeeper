class MangaKeeper::Manga
    attr_accessor :book_title, :likes, :release_day, :price

    @@all = []

    def initialize(book_title:, likes:, price:, release_day:)
        @book_title = book_title
        @likes = likes
        @price = price
        @release_day = release_day
        @@all << self
    end

    def self.all
        @@all
    end

    def print_manga
        puts "#{book_title} | #{likes} | #{release_day} | #{price}"
    end
end