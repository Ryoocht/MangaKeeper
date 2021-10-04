class MangaKeeper::SearchManga

    def free_word_search
        system("clear")
        divider
        puts "Type the title of manga"
        divider
        puts "Type the title of manga / Press 0 to go back to Search"
        input = gets.strip.downcase
        divider
        search_by_free_word(input)
    end

    def search_by_free_word(input)
        if input == "0"
            MangaKeeper::CLI.new.select_search
        else
            list = MangaKeeper::List.all.map{|manga| manga.manga_title}
            sorted_list = list.select{|title| title.downcase.include?(input)}
            sorted_list.each.with_index(1){|title, index| puts "#{index}. #{title}"}
            divider
            puts "If you find the manga, type a number of the title."
            puts "If there is no result, type 0 to go back to Search."
            title_number = gets.to_i
            if title_number == 0
                MangaKeeper::CLI.new.select_search
            else
                get_manga_details(title_number, sorted_list)
            end
        end
    end

    def alphabetical_search
        system("clear")
        divider
        puts "Type the first letter of title"
        divider
        puts "Type the first letter of title / Press 0 to go back to Search"
        input = gets.strip.upcase
        search_by_alphabet(input)
    end

    def search_by_alphabet(input)
        list = MangaKeeper::List.all.map{|manga| manga.manga_title}
        if input == "0"
            MangaKeeper::CLI.new.select_search
        elsif input.match(/[A-Z]/)
            divider
            sorted_list = list.grep(/^#{input}/).each.with_index(1) do |title, index|
                puts "#{index}. #{title}"
            end
            divider
            puts "Finally select a number of the title"
            title_number = gets.to_i
            check_correct_input(title_number, sorted_list)
        else
            puts "Type the first letter from A - Z / or 1(Back)"
            input = gets.strip.upcase
            search_by_alphabet(input)
        end
    end

    def check_correct_input(title_number, list)
        if title_number <= list.size
            get_manga_details(title_number, list)
        else
            puts "Select a number from 1 to the length of the list"
            input = gets.to_i
            check_correct_input(input, list)
        end
    end

    def get_manga_details(input, list)
        manga_title = list[input-1].downcase.gsub(" ", "-")
        MangaKeeper::BookScraper.new.get_all_manga_details(manga_title)
        MangaKeeper::Series.all.each{|series| series.print_series}
        MangaKeeper::Manga.all.each{|manga| manga.print_manga}
        puts "Do you wish to continue? y / n"
        last_input = gets.strip.downcase
        continue_or_exit(last_input)
    end

    def continue_or_exit(input)
        if input == "y"
            MangaKeeper::CLI.new.start
        elsif input == "n"
            system("exit")
        else
            puts "Please type either y or n"
        end
    end

    def category_search
        system("clear")
        divider
        genre_list = MangaKeeper::Genre.all.each.with_index(1) do |genre, index|
            puts "#{index}. #{genre.genre_title}"
        end
        divider
        puts "Select a number of genre / Press 0 to go back to Search"
        input = gets.to_i
        divider
        serach_by_category(input, genre_list)
    end

    def serach_by_category(input, genre_list)
        if input == 0
            MangaKeeper::CLI.new.select_search
        elsif input <= genre_list.size
            manga_list = []
            genre_title = genre_list[input-1].genre_title.strip.downcase.gsub(" ", "-")
            MangaKeeper::BookScraper.new.get_categorised_manga(genre_title)
            MangaKeeper::GenreManga.all.each.with_index(1) do |manga, index| 
                manga_list << manga.manga_title
                puts "#{index}. #{manga.manga_title}"
            end
            divider
            puts "Finally select a number of the title"
            title_number = gets.to_i
            get_manga_details(title_number, manga_list)
        else
            puts "Type a number from 1 to the length of the list"
            puts "Press 0 to go back to Search"
            try_again = gets.to_i
            serach_by_category(try_again, genre_list)
        end
    end

    def divider
        puts "=============================================="
    end

    def new_line
        puts ""
    end
end