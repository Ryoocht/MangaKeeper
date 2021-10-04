class MangaKeeper::CLI

    def initialize
        MangaKeeper::BookScraper.new.create_manga_and_genre_list
    end

    def start
        system("clear")
        puts "Welcome to Manga Keeper"
        divider
        puts "1. SEARCH MANGA"
        puts "2. FAVOURITE MANGA"
        puts "3. NEW RELEASE MANGA"
        puts "4. COMING SOON MANGA"
        divider
        puts "Select a number from Menu above or Press 0 to exit"
        input = gets.to_i
        menu_list(input)
    end

    def menu_list(input)
        case input
        when 0
            system("exit")
        when 1
            select_search
        when 2
            select_favourite
        when 3
            select_new_release
        when 4
            select_coming_soon
        else
            puts "Select a number from 1 to 4 / Press 0 to exit"
            input = gets.to_i
            menu_list(input)
        end
    end
    
    def select_search
        system("clear")
        puts "SEARCH MANGA"
        divider
        puts "1. Free Word Search"
        puts "2. Alphabetical Search"
        puts "3. Category Search"
        divider
        puts "Select a number to search / Press 4 to go back to Menu"
        input = gets.to_i
        search_list(input)
    end

    def search_list(input)
        case input
        when 1
            MangaKeeper::SearchManga.new.free_word_search
        when 2
            MangaKeeper::SearchManga.new.alphabetical_search
        when 3
            MangaKeeper::SearchManga.new.category_search
        when 4
            start
        else
            puts "Select a number from 1 to 3 or 4(Back)"
            input = gets.to_i
            search_list(input)
        end
    end

    def select_favourite
        puts "select_favourite method is invoked"
    end

    def select_new_release
        puts "Loading..."
        release_list(MangaKeeper::BookScraper.new_release_calendar)
    end

    def select_coming_soon
        puts "Loading..."
        release_list(MangaKeeper::BookScraper.coming_soon_calendar)
    end

    def release_list(new_or_coming)
        MangaKeeper::BookScraper.new.create_release_list(new_or_coming)
        MangaKeeper::Manga.all.map{|manga| manga.print_manga}
        puts "Press 0 to go back to search or 1 to exit"
        input = gets.to_i
        back_or_exit(input)
    end

    def back_or_exit(input)
        if input == 0
            select_search
        elsif input == 1
            system("exit")
        else
            puts "Press 0 or 1"
            try_again_input = gets.to_i
            back_or_exit(try_again_input) 
        end
    end

    def divider
        puts "=============================================="
    end

    def new_line
        puts ""
    end
end