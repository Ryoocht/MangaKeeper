class MangaKeeper::Series
    attr_accessor :title, :subtitle, :author

    @@all = []
    
    def initialize(title:, subtitle:, author:)
        @title = title
        @subtitle = subtitle
        @author = author
        @@all << self
    end

    def self.all
        @@all
    end

    def print_series
        system("clear")
        puts "======================="
        puts "Title: #{title}"
        puts "Subtitle: #{subtitle}"
        puts "Author: #{author}"
        puts "======================="
    end
end