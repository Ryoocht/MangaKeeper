class MangaKeeper::Genre
    attr_accessor :genre_title

    @@all = []

    def initialize(genre_title:)
        @genre_title = genre_title
        @@all << self
    end

    def self.all
        @@all
    end
end