class MangaKeeper::GenreManga
    attr_accessor :manga_title

    @@all = []

    def initialize(manga_title:)
        @manga_title = manga_title
        @@all << self
    end

    def self.all
        @@all
    end
end