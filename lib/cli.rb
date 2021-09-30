class MangaKeeper::CLI
    # SearchManga.new.show_all_result

    def initialize
        MangaKeeper::BookScraper.new.create_manga_list
    end

    def start
        # system("clear")
        puts "Welcome to Manga Keeper"
        puts "Select Manga"
        MangaKeeper::List.all.each{|manga| puts manga}
        # input = gets.strip.downcase

    end
end