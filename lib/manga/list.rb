class MangaKeeper::List
    attr_accessor :id, :manga_title

    @@all = []

    def initialize(id:, manga_title:)
        @id = id
        @manga_title = manga_title
        @@all << self
    end

    def self.all
        @@all
    end
end