class MangaKeeper::SearchManga
    # def show_all_manga_series
    #     MangaKeeper::List.all.map{|manga| puts "#{manga.id}. #{manga.manga_title}"}
    # end

    def free_word_search(search_word)
        
    end

    def alphabetical_search
        system("clear")
        divider
        puts "Type the first letter of title"
        divider
        puts "Type the first letter of title / Press 1 to go back to Search"
        input = gets.strip.upcase
        search_by_alphabet(input)
    end

    def search_by_alphabet(input)
        list = MangaKeeper::List.all.map{|manga| manga.manga_title}
        if input == "1"
            MangaKeeper::CLI.new.select_search
        elsif input.match(/[A-Z]/)
            divider
            sorted_list = list.grep(/^#{input}/).each.with_index(1) do |title, index|
                puts "#{index}. #{title}"
            end
            divider
            puts "Finally select a number of title"
            input = gets.to_i
            manga_title = sorted_list[input-1].gsub(" ", "-")
            MangaKeeper::BookScraper.new.get_all_manga(manga_title)
            puts MangaKeeper::Series.all
        else
            puts "Type the first letter from A - Z / or 1(Back)"
            input = gets.strip.upcase
            search_by_alphabet(input)
        end
    end

    def category_search(category)
        
    end

    def divider
        puts "=============================================="
    end

    def new_line
        puts ""
    end
end