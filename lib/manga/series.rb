class MangaKeeper::Series
    attr_accessor :title, :subtitle, :author, :url

    @@all = []
    
    def initialize(title:, subtitle:, author:, url:)
        @title = title
        @subtitle = subtitle
        @author = author
        @url = url
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