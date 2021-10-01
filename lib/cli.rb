class MangaKeeper::CLI

    def initialize
        MangaKeeper::BookScraper.new.create_manga_list
    end

    def start
        system("clear")
        puts "Welcome to Manga Keeper"
        divider
        puts "1. SEARCH MANGA"
        puts "2. FAVOURITE MANGA"
        puts "3. RANKING MANGA"
        puts "4. NEW RELEASE MANGA"
        puts "5. COMING SOON MANGA"
        divider
        puts "Select a number from Menu above"
        input = gets.to_i
        menu_list(input)
    end

    def menu_list(input)
        case input
        when 1
            select_search
        when 2
            select_favourite
        when 3
            select_ranking
        when 4
            select_new_release
        when 5
            select_coming_soon
        else
            puts "Select a number from 1 to 5"
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

        when 2
            MangaKeeper::SearchManga.new.alphabetical_search
        when 3

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

    def select_ranking
        puts "select_ranking method is invoked"
    end

    def select_new_release
        puts "select_new_release method is invoked"
    end

    def select_coming_soon
        puts "select_coming_soon method is invoked"
    end

    def divider
        puts "=============================================="
    end

    def new_line
        puts ""
    end
end