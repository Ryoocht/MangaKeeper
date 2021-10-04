class MangaKeeper::CLI

    @@prompt = TTY::Prompt.new

    def initialize
        MangaKeeper::BookScraper.new.create_manga_and_genre_list
    end

    def start
        system("clear")
        title
        puts "Welcome to Manga Keeper"
        divider
        choice = @@prompt.select("Choose one from Menu") do |menu|
            menu.choice "SEARCH MANGA", 1
            menu.choice "FAVOURITE MANGA", 2
            menu.choice "NEW RELEASE MANGA", 3
            menu.choice "COMING SOON MANGA", 4
            menu.choice "Exit",5
        end
        divider
        menu_list(choice)
    end

    def menu_list(input)
        case input
        when 1
            select_search
        when 2
            select_favourite
        when 3
            select_new_release
        when 4
            select_coming_soon
        when 5
            system("clear")
            system("exit")
            see_you
        else
            puts "Select a number from 1 to 4 / Press 0 to exit"
            input = gets.to_i
            menu_list(input)
        end
    end
    
    def select_search
        system("clear")
        title
        puts "SEARCH MANGA"
        divider
        choice = @@prompt.select("How do you want to search?") do |menu|
            menu.choice "Free Word Search", 1
            menu.choice "Alphabetical Search", 2
            menu.choice "Category Search", 3
            menu.choice "Go back to Menu", 4
            menu.choice "Exit",5
        end
        divider
        search_list(choice)
    end

    def search_list(choice)
        case choice
        when 1
            MangaKeeper::SearchManga.new.free_word_search
        when 2
            MangaKeeper::SearchManga.new.alphabetical_search
        when 3
            MangaKeeper::SearchManga.new.category_search
        when 4
            start
        when 5
            system("clear")
            system("exit")
            see_you
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
        choice = @@prompt.yes?("Do you wish to continue?")
        back_or_exit(choice)
    end

    def back_or_exit(choice)
        if choice == "Y"
            select_search
        else input == "n"
            system("exit")
        end
    end

    def title
        puts "      ░▒█▀▄▀█░█▀▀▄░█▀▀▄░█▀▀▀░█▀▀▄░░░▒█░▄▀░█▀▀░█▀▀░▄▀▀▄░█▀▀░█▀▀▄"
        puts "      ░▒█▒█▒█░█▄▄█░█░▒█░█░▀▄░█▄▄█░░░▒█▀▄░░█▀▀░█▀▀░█▄▄█░█▀▀░█▄▄▀"
        puts "      ░▒█░░▒█░▀░░▀░▀░░▀░▀▀▀▀░▀░░▀░░░▒█░▒█░▀▀▀░▀▀▀░█░░░░▀▀▀░▀░▀▀"
        puts ""
    end

    def see_you
        puts "       ┏━━━┓━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┏┓┏┓┏┓"
        puts "       ┃┏━┓┃━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┃┃┃┃┃┃"
        puts "       ┃┗━━┓┏━━┓┏━━┓━━━━┏┓━┏┓┏━━┓┏┓┏┓━━━━┃┃┃┃┃┃"
        puts "       ┗━━┓┃┃┏┓┃┃┏┓┃━━━━┃┃━┃┃┃┏┓┃┃┃┃┃━━━━┗┛┗┛┗┛"
        puts "       ┃┗━┛┃┃┃━┫┃┃━┫━━━━┃┗━┛┃┃┗┛┃┃┗┛┃━━━━┏┓┏┓┏┓"
        puts "       ┗━━━┛┗━━┛┗━━┛━━━━┗━┓┏┛┗━━┛┗━━┛━━━━┗┛┗┛┗┛"
        puts "       ━━━━━━━━━━━━━━━━━┏━┛┃━━━━━━━━━━━━━━━━━━━"
        puts "       ━━━━━━━━━━━━━━━━━┗━━┛━━━━━━━━━━━━━━━━━━━"
        puts ""
    end

    def divider
        puts "=============================================="
    end

    def new_line
        puts ""
    end
end