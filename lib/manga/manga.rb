class MangaKeeper::Manga
    attr_accessor :book_title, :likes

    @@all = []

    def initialize(book_title:, likes:, book_content:)
        @book_title = book_title
        @likes = likes
        book_content.each do |key, value|
            self.class.attr_accessor(key)
            self.send(("#{key}="), value)
        end
        @@all << self
    end

    def self.all
        @@all
    end

    def print_manga
        puts "#{book_title}   #{likes}   #{release_day}   #{price}"
    end
end